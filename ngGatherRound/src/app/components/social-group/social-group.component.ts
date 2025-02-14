import { CommonModule } from '@angular/common';
import { SocialGroup } from './../../models/social-group';
import { SocialGroupService } from './../../services/social-group.service';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';

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

  constructor (
    private socialGroupService: SocialGroupService,
  ) {}

  ngOnInit(): void {
    this.reloadSocialGroups();
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

}
