import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { DrugEntryComponent } from './drug-entry/drug-entry.component';
import { DrugEntryListComponent } from './drug-entry-list/drug-entry-list.component';

@NgModule({
  declarations: [
    AppComponent,
    DrugEntryComponent,
    DrugEntryListComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
