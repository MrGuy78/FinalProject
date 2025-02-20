import { Injectable } from '@angular/core';
import { Category } from '../models/category';
import { Observable, catchError, throwError } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { AuthService } from './auth.service';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class CategoryService {

private url = environment.baseUrl + 'api/categories';

constructor(
    private http: HttpClient,
    private auth: AuthService,
  ) { }

  index(): Observable<Category[]> {
      return this.http.get<Category[]>(this.url, this.getHttpOptions()).pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () => new Error('CategoryService.index(): error retrieving categories: ' + err)
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



