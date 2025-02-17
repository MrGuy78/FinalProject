import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-navigation',
  imports: [
    RouterLink,
    NgbModule,
    CommonModule
],
  templateUrl: './navigation.component.html',
  styleUrl: './navigation.component.css'
})
export class NavigationComponent {
// FIELDS
public isCollapsed = false;

constructor(
  private auth: AuthService,
  private router: Router,
) {}

// METHODS
loggedIn(): boolean {
  return this.auth.checkLogin();
}

logout() {
  console.log('Logging Out');
  this.auth.logout();
  this.router.navigateByUrl('/home');
}

}
