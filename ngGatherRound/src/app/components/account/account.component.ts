import { Router} from '@angular/router';
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
    FormsModule,

  ],
  templateUrl: './account.component.html',
  styleUrl: './account.component.css'
})
export class AccountComponent implements OnInit{

  // USER FIELDS
  loggedInUser: User = new User();
  user: User | null = null;
  isEditing: any;

  // GROUP FIELDS
  groups: SocialGroup[] = [];
  socialGroup: SocialGroup = new SocialGroup();
  isEditingGroup: any;
  selectedGroup: SocialGroup | null = null;
  showMyGroups: any;
  toggleMyGroups: boolean = false;
  ownedGroups: SocialGroup [] = [];

  // GROUP CATEGORY FIELDS
  categories: Category [] = [];

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

  // USER METHODS
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

  editProfile() {
    this.isEditing = true;
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

    cancelEdit() {
      this.isEditing = false;
     }

    saveEdits() {
      console.log('Profile Updated:', this.loggedInUser)
      this.isEditing = false;
    }

  // GROUP METHODS
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


  displayMyGroups() {
      console.log('Display Groups by Leader');
      this.showMyGroups = this.groups.filter(group => group.id === this.loggedInUser.id);
    }

  hideMyGroups() {
    this.showMyGroups = false;
  }

  editMyGroup(){
    this.isEditingGroup = true;
    }

  updateMyGroup(editGroup: SocialGroup) {
      this.socialGroupService.update(editGroup).subscribe({
        next: (updatedGroup) => {
          this.reloadOwnedGroups();
          this.selectedGroup = updatedGroup;
          this.isEditingGroup = false;
        },
        error: (error) => {
          console.error('AccountComponent.updateGroup: Error updating group');
          console.error(error);
        }
       });
    }

  cancelEditGroup() {
      this.isEditingGroup = false;
     }

  saveGroupEdits() {
    console.log('Group Updated:', this.socialGroup)
    }

  // GROUP CATEGORY METHODS
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

}
