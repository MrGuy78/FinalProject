import { SocialGroupService } from './../../services/social-group.service';
import { Component } from '@angular/core';
import { environment } from '../../../environments/environment';
import { ActivatedRoute, ParamMap, Router, RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Address } from '../../models/address';
import { Category } from '../../models/category';
import { GroupUser } from '../../models/group-user';
import { SocialEvent } from '../../models/social-event';
import { SocialGroup } from '../../models/social-group';
import { User } from '../../models/user';
import { AddressService } from '../../services/address.service';
import { AuthService } from '../../services/auth.service';
import { CategoryService } from '../../services/category.service';
import { GroupUserService } from '../../services/group-user.service';
import { SocialEventService } from '../../services/social-event.service';

@Component({
  selector: 'app-group-detail',
  imports: [
    RouterLink,
    CommonModule,
    FormsModule,
  ],
  templateUrl: './group-detail.component.html',
  styleUrl: './group-detail.component.css'
})
export class GroupDetailComponent {

  group: SocialGroup | null = null;
  groupMembers: GroupUser[] = [];
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

  categories: Category [] = [];
  selectedCategoryId: number | null = null;;
  filteredGroups: SocialGroup[] = [];

  constructor (
    private socialGroupService: SocialGroupService,
    private socialEventService: SocialEventService,
    private groupUserService: GroupUserService,
    private addressService: AddressService,
    private authService: AuthService,
    private router: Router,
    private categoryService: CategoryService,
    private activatedRoute: ActivatedRoute,
  ) {}

  ngOnInit(): void {
    this.getRouteParams();
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

  displayGroup(groupId: number){
    this.loadGroupUser(groupId);
    this.reloadAddresses(groupId);
    this.loadGroupMembers(groupId);
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
        this.selectedGroup = group;
      },
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

// GROUP CATEGORY METHODS
reloadGroupCategories() {
  this.categoryService.index().subscribe({
    next: (categories) => {
      this.categories = categories;
    } ,
    error: (failure) => {
      console.error('AccountComponent.reloadGroupCategories: failed to reload categories');
      console.error(failure);
    }
  });
}

loadGroup(groupId: number):void {
  this.socialGroupService.show(groupId).subscribe({
    next: (group) => {
      this.group = group;
    },
    error: (error) => {
      console.error('GroupMemberListComponent.loadGroup: Error loading group');
      console.error(error);
    }
  });
}

loadMembers(groupId: number):void {
  this.groupUserService.showAllUsers(groupId).subscribe({
    next: (members) => {
      this.groupMembers = members;
    },
    error: (error) => {
      console.error('GroupMemberListComponent.loadMembers: Error loading group members');
      console.error(error);
    }
  });
}

getRouteParams(){
    this.activatedRoute.paramMap.subscribe({
      next: (params: ParamMap) => {
        let groupIdParam = params.get("groupId");
        if(groupIdParam){
          let groupId = parseInt(groupIdParam);
          if(isNaN(groupId)){
            this.router.navigateByUrl("notFound");
          } else{
            this.loadGroup(groupId);
            this.groupDetail(groupId);
            this.displayGroup(groupId);
            this.displayGroupSocialEvents(groupId);
          }
        }
      },
      error: (error) => {
        console.error('GroupMemberListComponent.getRouteParams: Error getting route params');
        console.error(error);
      }
    });
  }

}
