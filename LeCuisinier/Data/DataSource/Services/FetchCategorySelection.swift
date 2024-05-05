//
//  FoodCategorySelection.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 3/05/24.
//

import Foundation

protocol FoodCategorySelectionProtocol {
  func fetch(selected category: String) async throws -> FoodCategoryDTO
}

class FoodCategorySelection: FoodCategorySelectionProtocol {
  private let networkService: NetworkServiceProtocol = NetworkService()

  func fetch(selected category: String) async throws -> FoodCategoryDTO {
    let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=\(category)"
    let category = try await networkService.fetchData(from: urlString, as: FoodCategoryDTO.self)
    return category
  }
}
