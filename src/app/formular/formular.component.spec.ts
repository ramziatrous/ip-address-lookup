import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FormularComponent } from './formular.component';

describe('FormularComponent', () => {
  let component: FormularComponent;
  let fixture: ComponentFixture<FormularComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [FormularComponent]
    });
    fixture = TestBed.createComponent(FormularComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
