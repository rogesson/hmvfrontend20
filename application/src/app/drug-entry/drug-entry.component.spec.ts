import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { DrugEntryComponent } from './drug-entry.component';

describe('DrugEntryComponent', () => {
  let component: DrugEntryComponent;
  let fixture: ComponentFixture<DrugEntryComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ DrugEntryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DrugEntryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
