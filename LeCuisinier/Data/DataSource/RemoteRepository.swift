//
//  RemoteRepository.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 24/04/24.
//

import Foundation

struct FoodServices {
  var category: FoodCategoryService
}

protocol RemoteRepositoryProtocol {
  var foodServices: FoodServices { get }
  func fetchFoodCategories() async throws -> [FoodCategory]
}

class RemoteRepository: RemoteRepositoryProtocol {
  var foodServices: FoodServices
  
  init(foodServices: FoodServices) {
    self.foodServices = foodServices
  }
  
  func fetchFoodCategories() async throws -> [FoodCategory] {
    let category = try await foodServices.category.fetchFoodCategoryService()
    return category
  }
}

protocol FoodCategoryServiceProtocol {
  func fetchFoodCategoryService() async throws -> [FoodCategory]
}

struct FoodCategoryService: FoodCategoryServiceProtocol {
  
  func fetchFoodCategoryService() async throws -> [FoodCategory] {
    guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php") else {
      throw FetchError.FailedFetching
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
      throw FetchError.FailedFetching
    }
    return try decodeDataFromServer(data: data)
  }
  
  private func decodeDataFromServer(data: Data) throws -> [FoodCategory] {
    do {
      let decoder = JSONDecoder()
      let categories = try decoder.decode([FoodCategory].self, from: data)
      return categories
    } catch {
      throw FetchError.FailedFetching
    }
  }
}

enum FetchError: Error {
  case FailedFetching
  case NoCategoriesFound
  case NoInternetConnection
}
