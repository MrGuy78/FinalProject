import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-logout',
  imports: [],
  templateUrl: './logout.component.html',
  styleUrl: './logout.component.css'
})
export class LogoutComponent {

  constructor(
    private auth: AuthService,
    private router: Router,
  ) {}

  // METHODS
  logout() {
    console.log('Logging Out');
    this.auth.logout();
    this.router.navigateByUrl('/home');
  }

}
