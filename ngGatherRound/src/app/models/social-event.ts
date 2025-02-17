
import { SocialGroup } from './social-group';
import { User } from './user';
import { Address } from './address';
import { end } from '@popperjs/core';
export class SocialEvent {

  id: number;
  title: string;
  description: string;
  eventDate: string;
  startTime: string;
  endTime: string;
  imageUrl: string;
  createDate: string;
  lastUpdate: string;
  cost: number;
  enabled: boolean;
  memeberOnly: boolean;
  user: User;
  meetAddress: Address;
  group: SocialGroup;

  constructor(
    id: number = 0,
    title: string = '',
    description: string = '',
    eventDate: string = '',
    startTime: string = '',
    endTime: string = '',
    imageUrl: string = '',
    createDate: string = '',
    lastUpdate: string = '',
    cost: number = 0,
    enabled: boolean = false,
    memeberOnly: boolean = false,
    user: User = new User(),
    meetAddress: Address = new Address(),
    group: SocialGroup = new SocialGroup(),

  ){
    this.id = id;
    this.title = title;
    this.description = description;
    this.eventDate = eventDate;
    this.startTime = startTime;
    this.endTime = endTime;
    this.imageUrl = imageUrl;
    this.createDate = createDate;
    this.lastUpdate = lastUpdate;
    this.cost = cost;
    this.enabled = enabled;
    this.memeberOnly = memeberOnly;
    this.user = user;
    this.meetAddress = meetAddress;
    this.group = group;
  }



}


