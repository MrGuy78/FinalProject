import { Router } from '@angular/router';
import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../services/auth.service';
import { User } from '../../models/user';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-account',
  imports: [CommonModule],
  templateUrl: './account.component.html',
  styleUrl: './account.component.css'
})
export class AccountComponent implements OnInit{

  loggedInUser: User = new User();

  constructor(private auth: AuthService,
      private router: Router,
  ){
  }
  ngOnInit(): void {
    if(this.auth.checkLogin()){
      this.getUser();
    }
   else{
    this.router.navigateByUrl('/home');
   }
  }

  getUser(){
    this.auth.getLoggedInUser().subscribe({
      next: (user) => {
        this.loggedInUser = user;
      },
      error: (failure) => {
        this.router.navigateByUrl('User not found');
      }
    })
  }

}
