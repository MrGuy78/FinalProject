import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from '../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { AuthService } from './auth.service';
import { SocialEvent } from '../models/social-event';

@Injectable({
  providedIn: 'root'
})
export class SocialEventService {

  private url = environment.baseUrl + 'api/events';

  constructor(
    private http : HttpClient,
    private auth: AuthService,
  ) { }


  groupsByName(groupName : string) : Observable<SocialEvent[]> {
    return this.http.get<SocialEvent[]>(this.url +'/' + groupName, this.getHttpOptions()  ).pipe(
      catchError((error:any) => {
        console.log(error);
        return throwError(
          () => new Error ('SocialEventService.show(): error finding event with name ' + groupName +  error.message)
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
