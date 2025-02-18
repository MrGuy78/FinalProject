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
import { group } from '@angular/animations';
import { setThrowInvalidWriteToSignalError } from '@angular/core/primitives/signals';

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
  user: User | null = null;
  isEditing: any;
  isEditingGroup: any;
  selectedGroup: any;
  showMyGroups: SocialGroup[] = [];
  toggleMyGroups: boolean = false;
  editGroup: SocialGroup | null = null;
  ownedGroups: SocialGroup [] = [];



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
      this.reloadSocialGroups();
      this.getUser();
      this.reloadGroupCategories();
      this.reloadOwnedGroups();
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

  reloadOwnedGroups() {
    this.socialGroupService.ownedGroups().subscribe({
      next: (socialGroups) => {
        this.ownedGroups = socialGroups;
      } ,
      error: (failure) => {
        console.error('OwnedGroupsComponent.reload: failed to reload groups');
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
          this.reloadOwnedGroups();
          this.socialGroup = new SocialGroup();
        } ,
        error: (failure) => {
          console.error('SocialGroupComponent.reload: failed to create a group');
          console.error(failure);
        }
      });
    }

  updateUser(user: User) : void {
    this.userService.update(user).subscribe({
      next: (updatedUser) => {
        this.loggedInUser = updatedUser;
      },
      error: (failure) => {
        console.error('AccountComponent.updateUser: Error updating user');
        console.error(failure);
      }
     });
    }

    editProfile() {
      this.isEditing = true;
    }

    saveEdits() {
      console.log('Profile Updated:', this.loggedInUser)
      this.isEditing = false;
    }

    cancelEdit() {
      this.isEditing = false;
    }

    displayMyGroups() {

      console.log('Display Groups by Leader');
      this.showMyGroups = this.groups.filter(group => group.id === this.loggedInUser.id);
    }

    editMyGroup(group: SocialGroup){
      console.log
    this.editGroup = group;
    }



}
