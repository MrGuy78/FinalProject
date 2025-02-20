import { last } from "rxjs";
import { User } from "./user";
import { Category } from "./category";
import { GroupUser } from "./group-user";

export class SocialGroup {
  id: number;
  name: string;
  description: string;
  imageUrl: string;
  createDate: string;
  lastUpdate: string;
  enabled: boolean;
  owner: User;
  category: Category;
  groupUsers: GroupUser[];

  constructor (
    id: number = 0,
    name: string = '',
    description: string = '',
    imageUrl: string = '',
    createDate: string = '',
    lastUpdate: string = '',
    enabled: boolean = false,
    owner: User = new User(),
    category: Category = new Category(),
    groupUsers: GroupUser[] = [],

  ) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.imageUrl = imageUrl;
    this.createDate = createDate;
    this.lastUpdate = lastUpdate;
    this.enabled = enabled;
    this.owner = owner;
    this.category = category;
    this.groupUsers = groupUsers;
  }
}
