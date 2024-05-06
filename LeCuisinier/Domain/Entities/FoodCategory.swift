//
//  FoodCategory.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 3/05/24.
//

import Foundation

struct FoodCategoriesResponse {
    var categories: [FoodCategory]
}

struct FoodCategory {
    var idCategory: String
    var strCategory: String
    var strCategoryThumb: String
    var strCategoryDescription: String
}
