//
//  FoodCategoryDTO.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 25/04/24.
//

import Foundation
import SwiftUI

struct FoodCategoriesResponseDTO: Codable {
    var categories: [FoodCategoryDTO]
}

struct FoodCategoryDTO: Codable {
    var idCategory: String
    var strCategory: String
    var strCategoryThumb: String
    var strCategoryDescription: String
}
