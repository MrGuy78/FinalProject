import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SocialEventComponent } from './social-event.component';

describe('SocialEventComponent', () => {
  let component: SocialEventComponent;
  let fixture: ComponentFixture<SocialEventComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SocialEventComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SocialEventComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
