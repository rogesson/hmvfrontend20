import { Injectable } from '@angular/core';
import { DrugEntry } from './drug-entry';
import { Observable, throwError } from 'rxjs';
import { catchError, retry } from 'rxjs/operators';
import { HttpClient, HttpHeaders, HttpErrorResponse } from
'@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class DrugEntryService {
  private drugRestUrl = 'http://localhost:8080/api/v1/userdetails';

  private httpOptions = {
    headers: new HttpHeaders( { 'Content-Type': 'application/json' })
  };

  constructor(private httpClient : HttpClient) { }

  getDrugEntries() : Observable<DrugEntry[]> {
    return this.httpClient.get<DrugEntry[]>(this.drugRestUrl, this.httpOptions)
    .pipe(retry(3),catchError(this.httpErrorHandler));
  }

  getDrugEntry(id: number) : Observable<DrugEntry> {
    return this.httpClient.get<DrugEntry>(this.drugRestUrl + "/" + id, this.httpOptions)
    .pipe(
      retry(3),
      catchError(this.httpErrorHandler)
    );
  }

  private httpErrorHandler (error: HttpErrorResponse) {
    if (error.error instanceof ErrorEvent) {
      console.error("A client side error occurs. The error message is " + error.message);
    } else {
      console.error(
        "An error happened in server. The HTTP status code is "  + error.status + " and the error returned is " + error.message);
    }

    return throwError("Error occurred. Pleas try again");
  }
}
