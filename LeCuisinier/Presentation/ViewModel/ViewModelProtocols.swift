//
//  ViewModelProtocols.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 4/05/24.
//

protocol FoodInteractorsProtocol {
  var fetchCategories: FetchCategoriesProtocol { get }
  var fetchSelectedCategory: FetchSelectedCategoryProtocol { get }
  var fetchSelectedMeal: FetchMealInteractorProtocol { get }
}

struct FoodInteractors: FoodInteractorsProtocol {
  var fetchCategories: FetchCategoriesProtocol
  var fetchSelectedCategory: FetchSelectedCategoryProtocol
  var fetchSelectedMeal: FetchMealInteractorProtocol
}
