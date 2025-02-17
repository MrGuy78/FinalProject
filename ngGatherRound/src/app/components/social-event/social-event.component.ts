import { Component } from '@angular/core';
import { SocialEvent } from '../../models/social-event';
import { SocialEventService } from '../../services/social-event.service';

@Component({
  selector: 'app-social-event',
  imports: [],
  templateUrl: './social-event.component.html',
  styleUrl: './social-event.component.css'
})
export class SocialEventComponent {


  constructor(
    private socialEventService: SocialEventService,
  ){}

  // METHODS


}
