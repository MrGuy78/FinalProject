import { GroupUserService } from './../../services/group-user.service';
import { SocialEventService } from './../../services/social-event.service';
import { SocialEvent } from './../../models/social-event';
import { CommonModule } from '@angular/common';
import { SocialGroup } from './../../models/social-group';
import { SocialGroupService } from './../../services/social-group.service';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { AuthService } from '../../services/auth.service';
import { User } from '../../models/user';
import { GroupUser } from '../../models/group-user';
import { AddressService } from '../../services/address.service';
import { Address } from '../../models/address';

@Component({
  selector: 'app-social-group',
  imports: [
    RouterLink,
    CommonModule,
    FormsModule,
  ],
  templateUrl: './social-group.component.html',
  styleUrl: './social-group.component.css'
})
export class SocialGroupComponent implements OnInit {

  groups: SocialGroup[] = [];
  socialGroup: SocialGroup = new SocialGroup();
  selectedGroup: SocialGroup | null = null;
  isEditingGroup: SocialGroup | null = null;

  events: SocialEvent[] = [];
  newSocialEvent: SocialEvent = new SocialEvent();
  selectedEvent: SocialEvent | null = null;
  editEvent: SocialEvent | null = null;

  loggedInUser: User | null = null;
  selectedGroupUser: GroupUser | null = null;
  selectedGroupMembers: GroupUser[] = [];


  // ADDRESS FIELDS
  addresses: Address [] = [];
  newAddress: Address = new Address();
  showNewAddressForm: any;

  constructor (
    private socialGroupService: SocialGroupService,
    private socialEventService: SocialEventService,
    private groupUserService: GroupUserService,
    private addressService: AddressService,
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
    this.reloadAddresses(socialGroup.id);
    this.loadGroupMembers(socialGroup.id);
  }

  loadGroupMembers(groupId: number){
    this.groupUserService.showAllUsers(groupId).subscribe({
      next: (members) => {
        this.selectedGroupMembers = members;
      } ,
      error: (failure) => {
        console.error('SocialGroupComponent.loadGroupMembers: failed to reload group users');
        console.error(failure);
      }
    })
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
      },
      error: (failure) => {
        console.error('SocialGroupComponent.reload: failed find events for group');
        console.error(failure);
      }
    });
  }

  createSocialEvent(socialEvent : SocialEvent, groupId: number) {
    this.socialEventService.create(socialEvent, groupId).subscribe({
      next: (groupEvent) => {
        this.newSocialEvent = new SocialEvent();
        this.displayGroupSocialEvents(groupId);
      },
      error: (error) => {
        console.error('SocialGroupComponent.createSocialEvent: Error Creating Event')
        console.error(error);
      }
    });

  }
  updateSocialEvent(socialEvent : SocialEvent, groupId: number) {
    this.socialEventService.update(socialEvent, groupId).subscribe({
      next: (socialEvent) => {
        this.displayGroupSocialEvents(groupId);
        this.editEvent = null;
        this.reloadAddresses(groupId);
      },
      error: (error) => {
        console.error('SocialGroupComponent.updateSocialEvent: Error Updating Event')
        console.error(error);
      }
    });
  }

  setEditEvent(socialEvent : SocialEvent){
    this.editEvent = {...socialEvent};
    // this.editEvent = Object.assign({}, this.selectedEvent); // try socialEvent"
  }
  cancelEditEvent() {
    this.editEvent = null;
   }


   //Group User Methods
  loadGroupUser(groupId: number) {
    this.groupUserService.show(groupId).subscribe({
      next: (groupUser) => {
        this.selectedGroupUser = groupUser;
        console.log(this.selectedGroupUser);
      },
      error: (error) => {
        console.error('SocialGroupComponent.loadGroupUser: Error Loading Group User')
        console.error(error);
      }
    });
  }





// ADDRESS METHODS
createAddress(groupId: number, eventId: number, address: Address) {
  this.addressService.createAddressForEvent(groupId, eventId, address).subscribe({
    next: (newAddress) => {
      this.newAddress = newAddress;
      this.reloadAddresses(groupId);
    },
    error: (error) => {
      console.error('SocialGroupComponent.createAddress: Error creating new address')
      console.error(error);
    }
  })
}

reloadAddresses(groupId: number) {
  this.addressService.index(groupId).subscribe({
    next: (addresses) => {
      this.addresses = addresses;
    } ,
    error: (error) => {
      console.error('AddressComponent.reload: failed to reload addresses');
      console.error(error);
    }
  });
}

toggleNewAddress() {
  this.showNewAddressForm = true;
  if(this.editEvent){
    this.editEvent.meetAddress.id = 0
  };
}

cancelNewAddress() {
  this.showNewAddressForm = false;
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
