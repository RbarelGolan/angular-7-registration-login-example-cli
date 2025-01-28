import {Component, OnInit} from '@angular/core';
import {Router} from '@angular/router';

import {AuthenticationService} from './_services';
import {User} from './_models';
import {loadRemoteModule} from '@angular-architects/module-federation';


@Component({selector: 'app', templateUrl: 'app.component.html'})
export class AppComponent implements OnInit {
  currentUser: User;

  constructor(
    private router: Router,
    private authenticationService: AuthenticationService
  ) {
    this.authenticationService.currentUser.subscribe(x => this.currentUser = x);
  }

  ngOnInit() {
    this.loadButton(); // Load the remote module
  }

  loadButton() {
    loadRemoteModule({
      remoteName: 'ButtonApp',
      remoteEntry: 'http://localhost:4202/remoteEntry.js',
      exposedModule: './ButtonComponent',
    })
      .then((m) => {
        const ButtonComponent = m.ButtonComponent;
        console.log('ButtonComponent', ButtonComponent);

      })
      .catch((err) => {
          console.error('Error loading remote module', err);
        }
      );
  }

  logout() {
    this.authenticationService.logout();
    this.router.navigate(['/login']);
  }
}