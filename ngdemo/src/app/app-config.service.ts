import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface Config {
  apiUrl: string;
}

@Injectable({
  providedIn: 'root'
})
export class AppConfigService {
  constructor(private http: HttpClient) { }
  getUrl():Observable<Config> {
   return this.http.get<Config>('/assets/config.json');
  }
}
