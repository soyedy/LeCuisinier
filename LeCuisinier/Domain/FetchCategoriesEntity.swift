//
//  FoodService.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 19/04/24.
//

import Foundation

struct FoodCategory: Codable {
  var idCategory: UUID
  var strCategory: String
  var strCategoryThumb: URL
  var strCategoryDescription: String
}

protocol FetchCategoryService {
  func fetchCategory() -> Category
}

