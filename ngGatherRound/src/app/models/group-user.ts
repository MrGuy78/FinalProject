import { GroupUserId } from "./group-user-id";
import { SocialGroup } from "./social-group";
import { User } from "./user";

export class GroupUser {
  id: GroupUserId;
  approved: boolean;
  createDate: string;
  approvedDate: string;
  leader: boolean;
  user: User;
  socialGroup: SocialGroup;

  constructor (
  id: GroupUserId = new GroupUserId(),
  approved: boolean = false,
  createDate: string = '',
  approvedDate: string = '',
  leader: boolean = false,
  user: User = new User(),
  socialGroup: SocialGroup = new SocialGroup,

  ) {
    this.id = id;
    this.approved = approved;
    this.createDate = createDate;
    this.approvedDate = approvedDate;
    this.leader = leader;
    this.user = user;
    this.socialGroup = socialGroup;
  }
}
