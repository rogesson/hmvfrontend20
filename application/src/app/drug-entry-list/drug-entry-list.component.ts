import { Component, OnInit } from '@angular/core';
import { DrugEntry } from '../drug-entry';

@Component({
  selector: 'app-drug-entry-list',
  templateUrl: './drug-entry-list.component.html',
  styleUrls: ['./drug-entry-list.component.scss']
})
export class DrugEntryListComponent implements OnInit {
  title: string;
  drugEntries: DrugEntry[];

  constructor() { }

  ngOnInit() {
    this.title = "Lista de Medicamentos";
    this.drugEntries = this.getDrugEntries();
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
