import { Router, RouterLink } from '@angular/router';
import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../services/auth.service';
import { User } from '../../models/user';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { SocialGroup } from '../../models/social-group';
import { CategoryService } from '../../services/category.service';
import { Category } from '../../models/category';
import { SocialGroupService } from '../../services/social-group.service';
import { UserService } from '../../services/user.service';

@Component({
  selector: 'app-account',
  imports: [
    CommonModule,
    RouterLink,
    FormsModule,

  ],
  templateUrl: './account.component.html',
  styleUrl: './account.component.css'
})
export class AccountComponent implements OnInit{

  loggedInUser: User = new User();
  groups: SocialGroup[] = [];
  categories: Category [] = [];
  socialGroup: SocialGroup = new SocialGroup();

  constructor(
    private auth: AuthService,
    private router: Router,
    private socialGroupService: SocialGroupService,
    private categoryService: CategoryService,
    private userService: UserService,
  ){
  }
  ngOnInit(): void {
    if(this.auth.checkLogin()){
      this.getUser();
      this.reloadGroupCategories();
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

  reloadSocialGroups() {
    this.socialGroupService.index().subscribe({
      next: (SocialGroups) => {
        this.groups = SocialGroups;
      } ,
      error: (failure) => {
        console.error('SocialGroupComponent.reload: failed to reload groups');
        console.error(failure);
      }
    });
  }

  reloadGroupCategories() {
    this.categoryService.index().subscribe({
      next: (categories) => {
        this.categories = categories;
      } ,
      error: (failure) => {
        console.error('GroupCategoryComponent.reload: failed to reload categories');
        console.error(failure);
      }
    });
  }

  createNewGroup(socialGroup: SocialGroup) {
      this.socialGroupService.create(socialGroup).subscribe({
        next: () => {
          this.reloadSocialGroups();
        } ,
        error: (failure) => {
          console.error('SocialGroupComponent.reload: failed to create a group');
          console.error(failure);
        }
      });
      this.socialGroup = new SocialGroup();
      this.reloadSocialGroups();
    }

  updateUser(user: User) {
    this.userService.update(user).subscribe({
      next: (updatedUser) => {
        this.getUser();
      },
      error: (failure) => {
        console.error('AccountComponent.updateUser: Error updating user');
        console.error(failure);
      }
     });
    }

}
