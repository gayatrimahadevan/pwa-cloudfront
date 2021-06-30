import { TestBed } from '@angular/core/testing';

import { MyquoteService } from './myquote.service';

describe('MyquoteService', () => {
  let service: MyquoteService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(MyquoteService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
