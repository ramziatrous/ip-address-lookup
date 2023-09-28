output "wordpress_url" {
  value = "http://${aws_instance.ec2_instance.public_ip}"
}
