import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { AuthService } from './auth.service';
import { environment } from '../../environments/environment';
import { User } from '../models/user';

@Injectable({
  providedIn: 'root'
})
export class UserService {

private url = environment.baseUrl + 'api/todos';

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

  update(user: User) : Observable<User> {
    return this.http.put<User>(this.url + '/' + user.id, user, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.index(): error updating user: ' + err)
        );
      })
    );
  }

}
