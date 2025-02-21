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
import { Address } from '../../models/address';
import { AddressService } from '../../services/address.service';
import { GroupUserService } from '../../services/group-user.service';
import { GroupUser } from '../../models/group-user';

@Component({
  selector: 'app-account',
  imports: [RouterLink, CommonModule, FormsModule],
  templateUrl: './account.component.html',
  styleUrl: './account.component.css',
})
export class AccountComponent implements OnInit {
  // USER FIELDS
  loggedInUser: User = new User();
  user: User | null = null;
  isSendingMessage: any;
  isViewingMessages: any;
  isEditing: any;

  // GROUP FIELDS
  groups: SocialGroup[] = [];
  socialGroup: SocialGroup = new SocialGroup();
  isEditingGroup: SocialGroup | null = null;
  selectedGroup: SocialGroup | null = null;
  showMyOwnedGroups: any;
  showMyJoinedGroups: any;
  toggleMyGroups: boolean = false;
  ownedGroups: SocialGroup[] = [];
  joinedGroups: SocialGroup[] = [];
  showNewGroupForm: any;
  selectedGroupUser: GroupUser | null = null;
  selectedGroupMembers: GroupUser[] = [];

  // GROUP CATEGORY FIELDS
  categories: Category[] = [];

  // ADDRESS FIELDS
  addresses: Address[] = [];

  constructor(
    private auth: AuthService,
    private router: Router,
    private socialGroupService: SocialGroupService,
    private categoryService: CategoryService,
    private addressService: AddressService,
    private groupUserService: GroupUserService,
    private userService: UserService
  ) {}

  ngOnInit(): void {
    if (this.auth.checkLogin()) {
      this.reloadSocialGroups();
      this.getUser();
      this.reloadGroupCategories();
      this.reloadOwnedGroups();
      this.reloadJoinedGroups();
    } else {
      this.router.navigateByUrl('/home');
    }
  }

  // USER METHODS
  getUser() {
    this.auth.getLoggedInUser().subscribe({
      next: (user) => {
        this.loggedInUser = user;
      },
      error: (failure) => {
        this.router.navigateByUrl('User not found');
      },
    });
  }

  sendDirectMessage() {
    this.isSendingMessage = true;
  }
  cancelDirectMessage() {
    this.isSendingMessage = false;
  }

  viewMessages() {
    this.isViewingMessages = true;
  }
  cancelViewMessages() {
    this.isViewingMessages = false;
  }

  editProfile() {
    this.isEditing = true;
  }

  updateUser(user: User): void {
    this.userService.update(user).subscribe({
      next: (updatedUser) => {
        this.loggedInUser = updatedUser;
      },
      error: (failure) => {
        console.error('AccountComponent.updateUser: Error updating user');
        console.error(failure);
      },
    });
  }

  cancelEdit() {
    this.isEditing = false;
  }

  saveEdits() {
    console.log('Profile Updated:', this.loggedInUser);
    this.isEditing = false;
  }

  // GROUP METHODS
  reloadSocialGroups() {
    this.socialGroupService.index().subscribe({
      next: (SocialGroups) => {
        this.groups = SocialGroups;
      },
      error: (failure) => {
        console.error(
          'AccountComponent.reloadSocialGroups: failed to reload groups'
        );
        console.error(failure);
      },
    });
  }

  reloadOwnedGroups() {
    this.socialGroupService.ownedGroups().subscribe({
      next: (socialGroups) => {
        this.ownedGroups = socialGroups;
      },
      error: (failure) => {
        console.error(
          'AccountComponent.reloadOwnedGroups: failed to reload groups'
        );
        console.error(failure);
      },
    });
  }

  reloadJoinedGroups() {
    this.socialGroupService.joinedGroups().subscribe({
      next: (socialGroups) => {
        this.joinedGroups = socialGroups;
      },
      error: (failure) => {
        console.error(
          'AccountComponent.reloadJoinedGroups: failed to reload groups'
        );
        console.error(failure);
      },
    });
  }

  toggleNewGroup() {
    this.showNewGroupForm = true;
  }

  cancelNewGroup() {
    this.showNewGroupForm = false;
  }

  createNewGroup(socialGroup: SocialGroup) {
    this.socialGroupService.create(socialGroup).subscribe({
      next: () => {
        this.reloadSocialGroups();
        this.reloadOwnedGroups();
        this.socialGroup = new SocialGroup();
        this.showNewGroupForm = false;
      },
      error: (failure) => {
        console.error(
          'AccountComponent.createNewGroup: failed to create a group'
        );
        console.error(failure);
      },
    });
  }

  displayGroup(socialGroup: SocialGroup) {
    this.selectedGroup = socialGroup;
    this.loadGroupUser(socialGroup.id);
    this.reloadAddresses(socialGroup.id);
    this.loadGroupMembers(socialGroup.id);
  }

  loadGroupUser(groupId: number) {
    this.groupUserService.show(groupId).subscribe({
      next: (groupUser) => {
        this.selectedGroupUser = groupUser;
        console.log(this.selectedGroupUser);
      },
      error: (error) => {
        console.error(
          'SocialGroupComponent.loadGroupUser: Error Loading Group User'
        );
        console.error(error);
      },
    });
  }

  reloadAddresses(groupId: number) {
    this.addressService.index(groupId).subscribe({
      next: (addresses) => {
        this.addresses = addresses;
      },
      error: (error) => {
        console.error('AddressComponent.reload: failed to reload addresses');
        console.error(error);
      },
    });
  }

  loadGroupMembers(groupId: number) {
    this.groupUserService.showAllUsers(groupId).subscribe({
      next: (members) => {
        this.selectedGroupMembers = members;
      },
      error: (failure) => {
        console.error(
          'SocialGroupComponent.loadGroupMembers: failed to reload group users'
        );
        console.error(failure);
      },
    });
  }

  displayMyOwnedGroups() {
    console.log('Display Groups');
    this.showMyOwnedGroups = this.groups.filter(
      (group) => group.id === this.loggedInUser.id
    );
  }

  hideMyOwnedGroups() {
    this.showMyOwnedGroups = false;
  }

  displayMyJoinedGroups() {
    console.log('Display Groups');
    this.showMyJoinedGroups = this.groups.filter(
      (group) => group.id === this.loggedInUser.id
    );
  }

  hideMyJoinedGroups() {
    this.showMyJoinedGroups = false;
  }

  editMyGroup(socialGroup: SocialGroup) {
    this.isEditingGroup = { ...socialGroup };
  }

  updateMyGroup(editGroup: SocialGroup) {
    this.socialGroupService.update(editGroup).subscribe({
      next: (updatedGroup) => {
        this.reloadOwnedGroups();
        this.selectedGroup = updatedGroup;
        this.isEditingGroup = null;
      },
      error: (error) => {
        console.error('AccountComponent.updateGroup: Error updating group');
        console.error(error);
      },
    });
  }

  cancelEditGroup() {
    this.isEditingGroup = null;
  }

  saveGroupEdits() {
    console.log('Group Updated:', this.socialGroup);
  }

  // GROUP CATEGORY METHODS
  reloadGroupCategories() {
    this.categoryService.index().subscribe({
      next: (categories) => {
        this.categories = categories;
      },
      error: (failure) => {
        console.error(
          'AccountComponent.reloadGroupCategories: failed to reload categories'
        );
        console.error(failure);
      },
    });
  }
}
