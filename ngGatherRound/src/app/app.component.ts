import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { AuthService } from './services/auth.service';

@Component({
  selector: 'app-root',
  imports: [RouterOutlet],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'ngGatherRound';


constructor(
  private auth: AuthService
) {}

ngOnInit() {
  this.tempTestDeleteMeLater(); // DELETE LATER!!!
}

tempTestDeleteMeLater() {
  this.auth.login('pickleballPlaya','test').subscribe({ // change username to match DB
    next: (data) => {
      console.log('Logged in:');
      console.log(data);
    },
    error: (fail) => {
      console.error('Error authenticating:')
      console.error(fail);
    }
  });
}
}
