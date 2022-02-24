import { Component, OnInit } from '@angular/core';
import { DrugEntry } from '../drug-entry';
import { DrugEntryService } from '../drug-entry.service';

@Component({
  selector: 'app-drug-entry-list',
  templateUrl: './drug-entry-list.component.html',
  styleUrls: ['./drug-entry-list.component.scss'],
  providers: []
})
export class DrugEntryListComponent implements OnInit {
  title: string;
  drugEntries: DrugEntry[];

  constructor(private restService : DrugEntryService ) { }

  ngOnInit() {
    this.title = "Lista de Medicamentos";
    //this.drugEntries = this.getDrugEntries();
    this.getDrugItemsFromServer();
  }

  getDrugItemsFromServer() {
    this.restService.getDrugEntries()
      .subscribe( data => this.drugEntries = data );
  }

  getDrugEntries() : DrugEntry[] {
    let drugs : DrugEntry[] = [
      {
        id: 1,
        name: "Neosaldina"
      },
      {
        id: 2,
        name: "Dipirona"
      }
    ];

    return drugs;
  }
}
