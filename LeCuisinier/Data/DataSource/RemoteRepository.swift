//
//  RemoteRepository.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 24/04/24.
//

import Foundation

protocol FoodServicesProtocol {
  var category: FoodCategoryServiceProtocol { get }
}

class FoodServices: FoodServicesProtocol {
  var category: FoodCategoryServiceProtocol
  
  init(category: FoodCategoryServiceProtocol) {
    self.category = category
  }
  
}

protocol RemoteRepositoryProtocol {
  func fetchFoodCategories() async throws -> [FoodCategory]
}

class RemoteRepository: RemoteRepositoryProtocol {
  var foodServices: FoodServicesProtocol
  
  init(foodServices: FoodServicesProtocol) {
    self.foodServices = foodServices
  }
  
  func fetchFoodCategories() async throws -> [FoodCategory] {
    return try await foodServices.category.fetchCategories()
  }
}

protocol FoodCategoryServiceProtocol {
  func fetchCategories() async throws -> [FoodCategory]
}

class FoodCategoryService: FoodCategoryServiceProtocol {
  
  func fetchCategories() async throws -> [FoodCategory] {
    guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php") else {
      throw FetchError.failedWhileFetching
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
      throw FetchError.failedWhileFetching
    }
    return try decodeDataFromServer(data: data)
  }
  
  private func decodeDataFromServer(data: Data) throws -> [FoodCategory] {
    do {
      let decoder = JSONDecoder()
      let categoriesResponse = try decoder.decode(FoodCategoriesResponse.self, from: data)
      let categories = categoriesResponse.categories
      return categories
    } catch {
      throw FetchError.failedWhileDecoding
    }
  }
}

enum FetchError: Error {
  case failedWhileFetching
  case failedWhileDecoding
  case noCategoriesFound
  case noInternetConnectionFound
}
