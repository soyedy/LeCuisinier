//
//  FoodViewModel.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 25/04/24.
//

import Foundation
import SwiftUI

protocol FoodViewModelProtocol: ObservableObject {
  func fetchFoodCategories() async
  func fetchMeals(by category: FoodCategory) async
  func fetchSelected(meal: Meal) async
}

class FoodViewModel: FoodViewModelProtocol {
  private var interactors: FoodInteractorsProtocol
  @Published var categories: [FoodCategory] = []
  @Published var mealsBySelectedCategory: [MealByCategory] = []
  
  init(interactors: FoodInteractorsProtocol) {
    self.interactors = interactors
  }
  
  func fetchFoodCategories() async {
    do {
      let fetchedCategories = try await interactors.fetchCategories.execute()
      await MainActor.run {
        self.categories = fetchedCategories
      }
    } catch {
      
    }
  }
  
  func fetchMeals(by category: FoodCategory) async {
    do {
      let meals = try await interactors.fetchSelectedCategory.execute(category: category.strCategory)
      await MainActor.run {
        self.mealsBySelectedCategory = meals
      }
    } catch {
      
    }
  }
  
  func fetchSelected(meal: Meal) async {
    
  }
  
}
