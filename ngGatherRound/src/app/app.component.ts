import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { AuthService } from './services/auth.service';
import { NavigationComponent } from './components/navigation/navigation.component';
import { FooterComponent } from "./components/footer/footer.component";

@Component({
  selector: 'app-root',
  imports: [
    RouterOutlet,
    NavigationComponent,
    FooterComponent,
],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})

export class AppComponent {
  title = 'GatherRound';


constructor(
  private auth: AuthService
) {}

// ngOnInit() {
//   this.tempTestDeleteMeLater(); // DELETE LATER!!!
// }

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
