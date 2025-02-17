import { SocialEventService } from './../../services/social-event.service';
import { SocialEvent } from './../../models/social-event';
import { CommonModule } from '@angular/common';
import { SocialGroup } from './../../models/social-group';
import { SocialGroupService } from './../../services/social-group.service';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../services/auth.service';
import { User } from '../../models/user';
import { GroupUser } from '../../models/group-user';

@Component({
  selector: 'app-social-group',
  imports: [
    CommonModule,
    FormsModule,
  ],
  templateUrl: './social-group.component.html',
  styleUrl: './social-group.component.css'
})
export class SocialGroupComponent implements OnInit {

  groups: SocialGroup[] = [];
  events: SocialEvent[] = [];
  newSocialEvent: SocialEvent = new SocialEvent();
  socialGroup: SocialGroup = new SocialGroup();
  selectedGroup: SocialGroup | null = null;
  loggedInUser: User | null = null;
  selectedGroupUser: GroupUser | null = null;

  constructor (
    private socialGroupService: SocialGroupService,
    private socialEventService: SocialEventService,
    private authService: AuthService,
    private router: Router,
  ) {}

  ngOnInit(): void {
    this.reloadSocialGroups();
    this.getLoggedInUser();
  }

  getLoggedInUser() {
    this.authService.getLoggedInUser().subscribe({
      next: (foundUser) => {
        this.loggedInUser = foundUser;
      },
      error: (error) => {
        console.error('SocialGroupComponent.getLoggedInUser: failed to retrieve logged in user');
        console.error(error);
      }
    });
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

  createNewGroup(socialGroup: SocialGroup) {
    this.socialGroupService.create(socialGroup).subscribe({
      next: (SocialGroups) => {
        this.reloadSocialGroups();
        this.socialGroup = new SocialGroup();
      } ,
      error: (failure) => {
        console.error('SocialGroupComponent.reload: failed to create a group');
        console.error(failure);
      }
    });
  }

  displayGroup(socialGroup : SocialGroup){
    this.selectedGroup = socialGroup;
    this.loadGroupUser(socialGroup.id);
  }

  groupDetail(groupId: number) {
    this.socialGroupService.show(groupId).subscribe({
      next: (group) => {
      } ,
      error: (failure) => {
        this.router.navigateByUrl('Group' + groupId + ' not found')
        console.error('GroupDetailComponent.reload: failed to reload groups');
        console.error(failure);
      }
    });
  }

  // EVENT METHODS
  displayGroupSocialEvents(groupId : number){
    this.socialEventService.groupsById(groupId).subscribe({
    next: (socialEventsByGroup) => {
      this.events = socialEventsByGroup;
      } ,
      error: (failure) => {
        console.error('SocialGroupComponent.reload: failed find events for group');
        console.error(failure);
      }
    });
  }

  createSocialEvent(socialEvent : SocialEvent, groupId: number) {
    this.socialEventService.create(socialEvent, groupId).subscribe({
      next: (groupEvents) => {
      this.displayGroupSocialEvents(groupId);
      },
      error: (error) => {
        console.error('TodoListComponent.createTodo: Error Creating Todo')
        console.error(error);
      }
    });
    this.newSocialEvent = new SocialEvent();
    this.displayGroupSocialEvents(groupId);
  }

  loadGroupUser(groupId: number) {
    // Subscribe to service to load group user, passing groupId

  }

  // isMember(): number {
  //   let className = "bg-";
  //   let membership = this.isMember();
  //   if (membership = 2) {
  //     className += "danger";
  //   } else {
  //     className += "success";
  //   }
  //   return className;
  // }

}
