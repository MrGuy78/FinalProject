import { last } from "rxjs";
import { User } from "./user";
import { Category } from "./category";

export class SocialGroup {
  id: number;
  name: string;
  description: string;
  imageUrl: string;
  createDate: string;
  lastUpdate: string;
  enabled: boolean;
  ownerId: User;
  groupCategoryId: Category;

  constructor (
    id: number = 0,
    name: string = '',
    description: string = '',
    imageUrl: string = '',
    createDate: string = '',
    lastUpdate: string = '',
    enabled: boolean = false,
    ownerId: User = new User(),
    groupCategoryId: Category = new Category(),

  ) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.imageUrl = imageUrl;
    this.createDate = createDate;
    this.lastUpdate = lastUpdate;
    this.enabled = enabled;
    this.ownerId = ownerId;
    this.groupCategoryId = groupCategoryId;
  }
}
