//
//  FoodServices.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 3/05/24.
//

import Foundation

protocol FoodServicesProtocol {
  var category: FoodCategoryServiceProtocol { get }
  var selectCategory: FoodCategorySelectionProtocol { get }
  var selectMeal: FoodDetailProtocol { get }
}

class FoodServices: FoodServicesProtocol {
  var category: FoodCategoryServiceProtocol
  var selectCategory: FoodCategorySelectionProtocol
  var selectMeal: FoodDetailProtocol
  
  init(category: FoodCategoryServiceProtocol, 
       selectCategory: FoodCategorySelectionProtocol,
       selectMeal: FoodDetailProtocol) {
    self.category = category
    self.selectCategory = selectCategory
    self.selectMeal = selectMeal
  }
}
