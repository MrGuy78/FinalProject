import { NgbAlertModule } from "@ng-bootstrap/ng-bootstrap";

export class Address {
id: number;
name: string;
address: string;
city: string;
state: string;
zip: string;

constructor(
  id: number = 0,
  name: string = '',
  address: string = '',
  city: string = '',
  state: string = '',
  zip: string = '',
){
this.id = id;
this.name = name;
this.address = address;
this.city = city;
this.state = state;
this.zip = zip;

}


}
