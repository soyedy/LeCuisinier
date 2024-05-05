//
//  FetchFoodDetail.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 3/05/24.
//

import Foundation

protocol FoodDetailProtocol {
  func fetch(selected meal: String) async throws -> [MealDTO]
}

class FoodDetail: FoodDetailProtocol {
  private let networkService: NetworkServiceProtocol = NetworkService()
  
  func fetch(selected meal: String) async throws -> [MealDTO] {
    let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(meal)"
    let meal = try await networkService.fetchData(from: urlString, as: MealsResponseDTO.self)
    return meal.meals
  }
}
