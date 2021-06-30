import { Component } from '@angular/core';
import { MyquoteService } from './myquote.service';

interface myQuote
{
  Version: String;
  Quote: String;
}

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'ngdemo';
  randomQuote: myQuote = {"Version": "0","Quote": ""};
  anyMsg: any;
  constructor(private api: MyquoteService) { }
  //constructor() {}
  onClick(){
    this.getQuote();
  }
  getQuote(){
//	  this.anyMsg = "{'Quote':'This is test.'}";
    this.api.getQuote()
        .subscribe(data => {
   	    this.randomQuote = data as myQuote;
   	 })
  }
}
