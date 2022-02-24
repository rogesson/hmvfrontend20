import { TestBed } from '@angular/core/testing';

import { DrugEntryService } from './drug-entry.service';

describe('DrugEntryService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: DrugEntryService = TestBed.get(DrugEntryService);
    expect(service).toBeTruthy();
  });
});
