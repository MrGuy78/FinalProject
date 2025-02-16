import { SocialGroupService } from './../../services/social-group.service';
import { Component } from '@angular/core';
import { environment } from '../../../environments/environment';
import { Router } from '@angular/router';
import { group } from '@angular/animations';

@Component({
  selector: 'app-group-detail',
  imports: [],
  templateUrl: './group-detail.component.html',
  styleUrl: './group-detail.component.css'
})
export class GroupDetailComponent {
  private url = environment.baseUrl + 'api/groups';

  constructor (
    private socialGroupService: SocialGroupService,
    private router: Router
  ) {}

  groupDetail(groupId: number) {
    this.socialGroupService.show(groupId).subscribe({
      next: (group) => {
        this.selected = group;
      } ,
      error: (failure) => {
        this.router.navigateByUrl('Group' + groupId + ' not found')
        console.error('GroupDetailComponent.reload: failed to reload groups');
        console.error(failure);
      }
    });
  }

}
