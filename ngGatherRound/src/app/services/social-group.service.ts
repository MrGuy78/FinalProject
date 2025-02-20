import { SocialGroup } from './../models/social-group';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { AuthService } from './auth.service';
import { environment } from '../../environments/environment';
import { GroupUser } from '../models/group-user';

@Injectable({
  providedIn: 'root'
})
export class SocialGroupService {

  private url = environment.baseUrl + 'api/groups';

  constructor(
    private http: HttpClient,
    private auth: AuthService,
  ) { }

  index(): Observable<SocialGroup[]> {
    return this.http.get<SocialGroup[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('GroupService.index(): error retrieving group: ' + err)
        );
      })
    );
  }

  ownedGroups(): Observable<SocialGroup[]> {
    return this.http.get<SocialGroup[]>(this.url  + '/owned' , this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('GroupService.index(): error retrieving group: ' + err)
        );
      })
    );
  }

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  show(groupId: number): Observable<SocialGroup> {
    return this.http.get<SocialGroup>(this.url + "/" + groupId, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('GroupService.show(): error retrieving group with id:' + err)
        );
      })
    );
  }

  create(socialGroup: SocialGroup): Observable<SocialGroup> {
    socialGroup.enabled = true;
    return this.http.post<SocialGroup>(this.url, socialGroup, this.getHttpOptions()).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError(
          () => new Error('GroupService.create(): error creating group: ' + error)
        );
      })
    );
  }

  update(socialGroup: SocialGroup): Observable<SocialGroup> {
    return this.http.put<SocialGroup>(this.url +'/' + socialGroup.id, socialGroup, this.getHttpOptions()).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError(
          () => new Error ('SocialGroupService.update(): error updating group: ' + error.message)
        );
      })
    );
  }

  newMember(groupId: number) : Observable<GroupUser> {
    return this.http.post<GroupUser>(this.url +'/' + groupId + '/members', null, this.getHttpOptions()).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError(
          () => new Error ('SocialGroupService.newMember(): error adding groupMember: ' + error.message)
        );
      })
    );
  }

  filterGroupsByCategory(categoryId: number): Observable<SocialGroup[]> {
    return this.http.get<SocialGroup[]>(this.url +'/categories/' + categoryId).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError(
          () => new Error ('SocialGroupService.filterGroupsByCategory(): error filtering by category: ' + error.message)
        );
      })
    );
  }


 }

