//
//  ServiceRepository.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 22/04/24.
//

import Foundation

struct FoodDataSource {
  var local: LocalRepository
  var remote: RemoteRepository
}

protocol FoodRepositoryProtocol {
  var repository: FoodDataSource { get }
  func fetchFoodCategoriesFromRemote() async throws -> [FoodCategory]
}

class FoodRepository: FoodRepositoryProtocol {
  var repository: FoodDataSource
  
  init(repository: FoodDataSource) {
    self.repository = repository
  }
  
  func fetchFoodCategoriesFromRemote() async throws -> [FoodCategory] {
    return try await repository.remote.foodServices.category.fetchFoodCategoryService()
  }
  
}
