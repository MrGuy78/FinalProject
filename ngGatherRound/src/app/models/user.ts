import { Address } from "./address";

export class User {
  id: number;
  username: string;
  password: string;
  firstName: string;
  lastName: string;
  email: string;
  phone: string;
  imageUrl: string;
  biography: string;
  role: string;
  enabled: boolean;
  createDate: string;
  lastUpdate: string;
  address: Address | null;

  constructor (
    id: number = 0,
    username: string = '',
    password: string = '',
    firstName: string = '',
    lastName: string = '',
    email: string = '',
    phone: string = '',
    imageUrl: string = '',
    biography: string = '',
    enabled: boolean = false,
    role: string = '',
    createDate: string = '',
    lastUpdate: string = '',
    address: Address = new Address(),
  )   {
    this.id = id;
    this.username = username;
    this.password = password;
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.phone = phone;
    this.imageUrl = imageUrl;
    this.biography = biography;
    this.enabled = enabled;
    this.role = role;
    this.createDate = createDate;
    this.lastUpdate = lastUpdate;
    this.address = address;

  }


}
