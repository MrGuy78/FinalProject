import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SocialGroupComponent } from './social-group.component';

describe('SocialGroupComponent', () => {
  let component: SocialGroupComponent;
  let fixture: ComponentFixture<SocialGroupComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SocialGroupComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SocialGroupComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
