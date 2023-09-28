# Define the AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "Ramzi"
}

# Create VPCs
resource "aws_vpc" "VPC1" {
  cidr_block       = "10.0.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "vpc1"
  }
}

# create Subnets in both VPCs
resource "aws_subnet" "SB1" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block = "10.0.0.0/24"
}
# create Internet Gateways
resource "aws_internet_gateway" "igw_a" {
  vpc_id = aws_vpc.VPC1.id
  tags = {
    Name = "igw_a"
  }
}
# edit default route table
resource "aws_default_route_table" "a" {
  default_route_table_id = aws_vpc.VPC1.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_a.id
  }

}
# create ENIs for  VPC
resource "aws_network_interface" "eni_vpc_1" {
  description     = "ENI for Subnet VPC1"
  subnet_id       = aws_subnet.SB1.id
  security_groups = [aws_security_group.instance_a_sg.id]
  attachment {
    instance     = aws_instance.ec2_instance.id
    device_index = 1
  }
}
# define security_groups per vpc
resource "aws_security_group" "instance_a_sg" {
  name        = "instance_a_sg"
  description = "SG of Instances in VPC1"
  vpc_id      = aws_vpc.VPC1.id
  ingress {
    description = "SSH from Everywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "MYSQL from Everywhere"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP from Everywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Create an EC2 instance
resource "aws_instance" "ec2_instance" {
  ami                         = "ami-06dd92ecc74fdfb36"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.SB1.id
  associate_public_ip_address = true
  key_name                    = "ssh-september" # Change to your desired SSH key name
  tags = {
    Name = "MyEC2Instance"
  }
  vpc_security_group_ids = [aws_security_group.instance_a_sg.id]
  user_data              = <<-EOF
              #!/bin/bash
              sudo apt-get update -y


              EOF
  connection {
    type        = "ssh"
    host        = aws_instance.ec2_instance.public_ip
    user        = "ubuntu"
    private_key = file("ssh-september.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "usermod -aG docker ubuntu",
      "sudo apt-get install git",
      "git clone https://github.com/ramziatrous/ip-address-lookup.git",
      "cd ip-address-lookup",
      "docker build -t ipcheck .",
      "docker run --name ipcheck -p 8080:80",

    ]
  }
}



