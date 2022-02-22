import { Component, OnInit } from '@angular/core';
import { DrugEntry } from '../drug-entry';

@Component({
  selector: 'app-drug-entry',
  templateUrl: './drug-entry.component.html',
  styleUrls: ['./drug-entry.component.scss']
})
export class DrugEntryComponent implements OnInit {
  title: string
  isLogIn : boolean = false;
  drugEntry: DrugEntry;

  constructor() { }

  ngOnInit() {
    this.title = "Medicamentos";
    this.isLogIn = true;

    this.drugEntry = {
      id: 6,
      name: "Novalgina"
    }
  }
}
