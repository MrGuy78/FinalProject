import { SocialGroupService } from './../../services/social-group.service';
import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { GroupRolePipe } from '../../pipes/group-role.pipe';
import { GroupUserService } from '../../services/group-user.service';
import { SocialGroup } from '../../models/social-group';
import { ActivatedRoute, ParamMap, Router } from '@angular/router';
import { GroupUser } from '../../models/group-user';

@Component({
  selector: 'app-group-member-list',
  imports: [CommonModule, GroupRolePipe],
  templateUrl: './group-member-list.component.html',
  styleUrl: './group-member-list.component.css'
})
export class GroupMemberListComponent implements OnInit{

  group: SocialGroup | null = null;
  groupId: number = 0;
  groupMembers: GroupUser[] = [];
  showLeaders: boolean = false;

constructor(
  private socialGroupService: SocialGroupService,
  private groupUserService: GroupUserService,
  private router: Router,
  private activatedRoute: ActivatedRoute,){
}
// social-group/:groupId/members


  ngOnInit(): void {
    this.getRouteParams();
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
            this.loadMembers(groupId);
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
