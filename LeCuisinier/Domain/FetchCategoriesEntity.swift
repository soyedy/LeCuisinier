//
//  FoodService.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 19/04/24.
//

import Foundation

protocol FetchCategoriesProtocol {
  func execute() async throws -> [FoodCategory]
}

class FetchCategoriesEntity: FetchCategoriesProtocol {
  var repository: FoodRepositoryProtocol
  
  init(repository: FoodRepositoryProtocol) {
    self.repository = repository
  }
  
  func execute() async throws -> [FoodCategory] {
    return try await repository.fetchFoodCategoriesFromRemote()
  }
  
}


