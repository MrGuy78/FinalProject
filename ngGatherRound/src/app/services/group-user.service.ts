import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { AuthService } from './auth.service';
import { environment } from '../../environments/environment';
import { Observable, catchError, throwError } from 'rxjs';
import { GroupUser } from '../models/group-user';

@Injectable({
  providedIn: 'root'
})
export class GroupUserService {

  private url = environment.baseUrl + 'api/groups';

  constructor(
    private http: HttpClient,
    private auth: AuthService,
  ) { }

    getHttpOptions() {
      let options = {
        headers: {
          Authorization: 'Basic ' + this.auth.getCredentials(),
          'X-Requested-With': 'XMLHttpRequest',
        },
      };
      return options;
    }

    show(groupId: number): Observable<GroupUser> {
      return this.http.get<GroupUser>(this.url + "/" + groupId + "/groupUsers", this.getHttpOptions()).pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () => new Error('GroupUser.show(): error retrieving group user:' + err)
          );
        })
      );
    }

    showAllUsers(groupId: number): Observable<GroupUser[]> {
      return this.http.get<GroupUser[]>(this.url + "/" + groupId + "/groupUsers/all", this.getHttpOptions()).pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () => new Error('GroupUser.showAllUsers: error retrieving all groupusers:' + err)
          );
        })
      );
    }


}


