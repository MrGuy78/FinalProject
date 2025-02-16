import { Component } from '@angular/core';
import { User } from '../../models/user';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-login',
  imports: [
    CommonModule,
    FormsModule,
  ],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css'
})
export class LoginComponent {

  // FIELDS
  loginUser: User = new User();

  constructor(
    private auth: AuthService,
    private router: Router,
  ) {}

  // METHODS
  login(user: User) {
    console.log(user);
    this.auth.login(user.username, user.password).subscribe({
      next: (loggedInUser) => {
        this.router.navigateByUrl('/account');
      },
      error: (error) => {
        console.error('LoginComponent.login(): Error Logging In:');
        console.error(error);
        alert("Account has been disabled");
      }
    });
  }

}
