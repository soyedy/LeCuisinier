//
//  FetchSelectedCategory.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 28/04/24.
//

protocol FetchSelectedCategoryProtocol {
  func execute(category: String) async throws -> [MealByCategory]
}

class FetchSelectedCategory: FetchSelectedCategoryProtocol {
  private var repository: FoodRepositoryProtocol
  
  init(repository: FoodRepositoryProtocol) {
    self.repository = repository
  }
  
  func execute(category: String) async throws -> [MealByCategory] {
    let meals = try await repository.fetchMealsBySelected(category: category)
    return meals.compactMap { meal in
      MealByCategory(strMeal: meal.strMeal, strMealThumb: meal.strMealThumb, idMeal: meal.idMeal)
    }
  }
}
