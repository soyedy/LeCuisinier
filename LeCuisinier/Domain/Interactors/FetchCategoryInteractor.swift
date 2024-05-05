//
//  FetchSelectedCategory.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 28/04/24.
//

protocol FetchSelectedCategoryProtocol {
  func exectute(category: String) async throws -> FoodCategory
}

class FetchSelectedCategory: FetchSelectedCategoryProtocol {
  private var repository: FoodRepositoryProtocol
  
  init(repository: FoodRepositoryProtocol) {
    self.repository = repository
  }
  
  func exectute(category: String) async throws -> FoodCategory {
    let category = try await repository.fetchSelectedCategoryFromRemote(category)
    return FoodCategory(idCategory: category.idCategory,
                        strCategory: category.strCategory,
                        strCategoryThumb: category.strCategoryThumb,
                        strCategoryDescription: category.strCategoryDescription)
  }
}
