import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { DrugEntryListComponent } from './drug-entry-list.component';

describe('DrugEntryListComponent', () => {
  let component: DrugEntryListComponent;
  let fixture: ComponentFixture<DrugEntryListComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ DrugEntryListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DrugEntryListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
