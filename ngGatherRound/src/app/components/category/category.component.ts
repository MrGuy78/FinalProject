import { Category } from '../../models/category';
import { CategoryService } from './../../services/category.service';
import { Component } from '@angular/core';

@Component({
  selector: 'app-category',
  imports: [],
  templateUrl: './category.component.html',
  styleUrl: './category.component.css'
})
export class CategoryComponent {

  categories: Category [] = [];

  constructor(

    private categoryService: CategoryService,

  ){}

  reloadGroupCategories() {
    this.categoryService.index().subscribe({
      next: (categories) => {
        this.categories = categories;
      } ,
      error: (failure) => {
        console.error('GroupCategoryComponent.reload: failed to reload categories');
        console.error(failure);
      }
    });
  }




}
