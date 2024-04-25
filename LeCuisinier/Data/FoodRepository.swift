//
//  ServiceRepository.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 22/04/24.
//

import Foundation

protocol FoodRepositoryProtocol {
  func fetchFoodCategoriesFromRemote() async throws -> [FoodCategory]
}

class FoodRepository: FoodRepositoryProtocol {
  private var localManager: LocalRepository
  private var remoteManager: RemoteRepository
  
  init(localManager: LocalRepository, remoteManager: RemoteRepository) {
    self.localManager = localManager
    self.remoteManager = remoteManager
  }
  
  func fetchFoodCategoriesFromRemote() async throws -> [FoodCategory] {
    return try await remoteManager.foodServices.category.fetchCategories()
  }
  
}
