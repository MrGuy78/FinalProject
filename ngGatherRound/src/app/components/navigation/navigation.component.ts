import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { LogoutComponent } from '../logout/logout.component';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-navigation',
  imports: [
    RouterLink,
    NgbModule,
    CommonModule,
    LogoutComponent,
  ],
  templateUrl: './navigation.component.html',
  styleUrl: './navigation.component.css'
})
export class NavigationComponent {
// FIELDS
public isCollapsed = false;

constructor(
  private auth: AuthService,
) {}

// METHODS
loggedIn(): boolean {
  return this.auth.checkLogin();
}

}
