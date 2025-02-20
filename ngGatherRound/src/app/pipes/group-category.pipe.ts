import { Pipe, PipeTransform } from '@angular/core';
import { SocialGroup } from '../models/social-group';

@Pipe({
  name: 'groupCategory'
})
export class GroupCategoryPipe implements PipeTransform {

  transform(socialGroups: SocialGroup[] , categoryName: string ): SocialGroup[] {

    if(categoryName === 'all'){
      return socialGroups;
    }

    let result: SocialGroup[] = [];
    for(let group of socialGroups){
      if(group.category.name == categoryName){
        result.push(group);
      }
    }
    return result;
  }

}
