//
//  RemoteRepository.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 24/04/24.
//

import Foundation

protocol RemoteRepositoryProtocol {
  func fetchFoodCategories() async throws -> [FoodCategoryDTO]
  func fetchMeals(by category: String) async throws -> [MealByCategoryDTO]
  func fetchMeal(by meal: String) async throws -> [MealDTO]
}

class RemoteRepository: RemoteRepositoryProtocol {
  private let foodServices: FoodServicesProtocol
  
  init(foodServices: FoodServicesProtocol) {
    self.foodServices = foodServices
  }
  
  func fetchFoodCategories() async throws -> [FoodCategoryDTO] {
    return try await foodServices.category.fetchCategories()
  }
  
  func fetchMeals(by category: String) async throws -> [MealByCategoryDTO] {
    return try await foodServices.selectCategory.fetch(selected: category)
  }
  
  func fetchMeal(by meal: String) async throws -> [MealDTO] {
    return try await foodServices.selectMeal.fetch(selected: meal)
  }
  
}
