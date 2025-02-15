import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { AuthService } from './auth.service';
import { environment } from '../../environments/environment';
import { SocialGroup } from '../models/social-group';

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
    return this.http.get<SocialGroup[]>(this.url, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('GroupService.index(): error retrieving todo: ' + err)
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

}
