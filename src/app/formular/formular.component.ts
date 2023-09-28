import { Component, OnInit } from '@angular/core';
import { IpApiService } from '../Service/ip-api.service';
import * as L from 'leaflet';
@Component({
  selector: 'app-formular',
  templateUrl: './formular.component.html',
  styleUrls: ['./formular.component.css']
})
export class FormularComponent implements OnInit {

  ipAddress: string = '';
  ipDetails: any;

  constructor(private ipApiService: IpApiService) { }

  ngOnInit(): void {}
  Submit() {
    this.ipApiService.getIpDetails(this.ipAddress).subscribe((data) => {
      this.ipDetails = data;

    });
  }



}
