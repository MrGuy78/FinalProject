import { GroupMemberListComponent } from './components/group-member-list/group-member-list.component';
import { Routes } from '@angular/router';
import { HomeComponent } from './components/home/home.component';
import { RegisterComponent } from './components/register/register.component';
import { LoginComponent } from './components/login/login.component';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { AccountComponent } from './components/account/account.component';
import { SocialGroupComponent } from './components/social-group/social-group.component';
import { GroupDetailComponent } from './components/group-detail/group-detail.component';

export const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'home'},
  { path: 'home', component: HomeComponent},
  { path: 'register', component: RegisterComponent},
  { path: 'login', component: LoginComponent},
  { path: 'account', component: AccountComponent},
  { path: 'social-group', component: SocialGroupComponent},
  { path: 'social-group/:groupId', component: GroupDetailComponent},
  { path: 'social-group/:groupId/members', component: GroupMemberListComponent},
  { path: '**', component: NotFoundComponent},

];
