import 'core-js/es7/reflect';
import 'zone.js/dist/zone';

import {loadRemoteModule} from '@angular-architects/module-federation';
import {enableProdMode} from '@angular/core';
import {platformBrowserDynamic} from '@angular/platform-browser-dynamic';

import {AppModule} from '@app/app.module';
import {environment} from '@environments/environment';

if (environment.production) {
  enableProdMode();
}

platformBrowserDynamic().bootstrapModule(AppModule)
  .catch(err => console.error(err));

loadRemoteModule({
  remoteEntry: 'http://localhost:4201/remoteEntry.js',
  remoteName: 'Angular7MF',
  exposedModule: './Component'
}).then(m => {
  platformBrowserDynamic().bootstrapModule(AppModule)
    .catch(err => console.error(err));
});