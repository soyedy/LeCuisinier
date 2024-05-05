//
//  FoodCategoryService.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 3/05/24.
//

import Foundation

protocol FoodCategoryServiceProtocol {
  func fetchCategories() async throws -> [FoodCategoryDTO]
}

class FoodCategoryService: FoodCategoryServiceProtocol {
  private let networkService: NetworkServiceProtocol = NetworkService()
  
  func fetchCategories() async throws -> [FoodCategoryDTO] {
    let urlString = "https://www.themealdb.com/api/json/v1/1/categories.php"
    let category = try await networkService.fetchData(from: urlString, as: FoodCategoriesResponseDTO.self)
    return category.categories
  }
}
