//
//  ServiceRepository.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 22/04/24.
//

import Foundation

protocol FoodRepositoryProtocol {
  func fetchFoodCategoriesFromRemote() async throws -> [FoodCategoryDTO]
  func fetchSelectedCategoryFromRemote(_ category: String) async throws -> FoodCategoryDTO
  func fetchSelectedMealFromCategory(meal id: String) async throws -> [MealDTO]
}

class FoodRepository: FoodRepositoryProtocol {
  private var localManager: LocalRepository
  private var remoteManager: RemoteRepository
  
  init(localManager: LocalRepository, remoteManager: RemoteRepository) {
    self.localManager = localManager
    self.remoteManager = remoteManager
  }
  
  func fetchFoodCategoriesFromRemote() async throws -> [FoodCategoryDTO] {
    return try await remoteManager.fetchFoodCategories()
  }
  
  func fetchSelectedCategoryFromRemote(_ category: String) async throws -> FoodCategoryDTO {
    return try await remoteManager.fetchFoodCategory(by: category)
  }
  
  func fetchSelectedMealFromCategory(meal: String) async throws -> [MealDTO] {
    return try await remoteManager.fetchMeal(by: meal)
  }
  
}
