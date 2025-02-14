import { TestBed } from '@angular/core/testing';

import { SocialGroupService } from './social-group.service';

describe('SocialGroupService', () => {
  let service: SocialGroupService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(SocialGroupService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
