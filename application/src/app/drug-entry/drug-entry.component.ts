import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-drug-entry',
  templateUrl: './drug-entry.component.html',
  styleUrls: ['./drug-entry.component.scss']
})
export class DrugEntryComponent implements OnInit {
  title: string

  constructor() { }

  ngOnInit() {
    this.title = "Medicamentos"
  }

}
