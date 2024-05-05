//
//  FoodService.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 19/04/24.
//

protocol FetchCategoriesProtocol {
  func execute() async throws -> [FoodCategory]
}

class FetchCategoriesInteractor: FetchCategoriesProtocol {
  private var repository: FoodRepositoryProtocol
  
  init(repository: FoodRepositoryProtocol) {
    self.repository = repository
  }
  
  func execute() async throws -> [FoodCategory] {
    let categories = try await repository.fetchFoodCategoriesFromRemote()
    return categories.compactMap { category in
      FoodCategory(idCategory: category.idCategory,
                   strCategory: category.strCategory,
                   strCategoryThumb: category.strCategoryThumb,
                   strCategoryDescription: category.strCategoryDescription)
    }
  }
  
}


