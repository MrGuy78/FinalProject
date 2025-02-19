import { Pipe, PipeTransform } from '@angular/core';
import { GroupUser } from '../models/group-user';

@Pipe({
  name: 'groupRole'
})
export class GroupRolePipe implements PipeTransform {

  transform(members: GroupUser[], leadersOnly: boolean = false): GroupUser[] {
    let result: GroupUser[] = [];
    for(let member of members){
      if(member.leader === leadersOnly){
          result.push(member);
      }
    }
    return result;
  }

}
