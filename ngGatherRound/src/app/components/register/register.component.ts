import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { User } from '../../models/user';
import { CommonModule } from '@angular/common';
import { AuthService } from '../../services/auth.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-register',
  imports: [
    CommonModule,
    FormsModule,
  ],
  templateUrl: './register.component.html',
  styleUrl: './register.component.css'
})
export class RegisterComponent {

  // FIELDS
  newUser: User = new User();
username: any;

  constructor(
    private auth: AuthService,
    private router: Router,
  ) {}

  // METHODS
  register(user: User): void {
    console.log('Registering user:');
    console.log(user);
    this.auth.register(user).subscribe({
      next: (registeredUser) => {
        this.auth.login(user.username, user.password).subscribe({
          next: (loggedInUser) => {
            this.router.navigateByUrl('/account');
          },
          error: (error) => {
            console.error('RegisterComponent.register(): Error Logging in User:');
            console.error(error);
          }
        });
      },
      error: (error) => {
        console.error('RegisterComponent.register(): Error Registering Account');
        console.error(error);
        alert('Username ' + user.username +  ' Already Taken');
      }
    });
  }



}
