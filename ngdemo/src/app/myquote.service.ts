import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { AppConfigService, Config } from './app-config.service';
@Injectable({
  providedIn: 'root'
})
export class MyquoteService {
  tempConfig: Config = {"apiUrl":''};
  quoteUrl:string='';
  constructor(private http: HttpClient, private appConfig: AppConfigService) {  }
  getQuote():Observable<any>{
    this.appConfig.getUrl().subscribe(data => {this.tempConfig = data;});
    this.quoteUrl=this.tempConfig.apiUrl; 
    return this.http.get<any>(this.quoteUrl);
  }
}
