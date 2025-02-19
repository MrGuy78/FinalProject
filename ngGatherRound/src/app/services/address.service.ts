import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { AuthService } from './auth.service';
import { environment } from '../../environments/environment';
import { Observable, catchError, throwError } from 'rxjs';
import { Address } from '../models/address';

@Injectable({
  providedIn: 'root'
})
export class AddressService {

  private groupUrl = environment.baseUrl + 'api/groups';
  private eventUrl = environment.baseUrl + '/events';

  constructor(
    private http : HttpClient,
    private auth: AuthService,
  ) { }

  createAddressForEvent(groupId : number, eventId: number, address: Address) : Observable<Address> {
    return this.http.post<Address>(this.groupUrl +'/' + groupId + this.eventUrl + '/' + eventId + '/address', address, this.getHttpOptions()).pipe(
      catchError((error:any) => {
        console.log(error);
        return throwError(
          () => new Error ('AddressService.createAddressForEvent(): error creating address for groupId' + groupId + error.message)
        );
      })
    );
  }

  index(groupId: number): Observable<Address[]> {
    return this.http.get<Address[]>(this.groupUrl + '/' + groupId + '/addresses', this.getHttpOptions()).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError(
          () => new Error('AddressService.index(): error retrieving addresses: ' + error)
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
