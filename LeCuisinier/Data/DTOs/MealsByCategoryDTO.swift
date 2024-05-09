//
//  MealsByCategoryDTO.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 8/05/24.
//

struct MealsByCategoryDTO: Codable {
  var meals: [MealByCategoryDTO]
}

struct MealByCategoryDTO: Codable {
  var strMeal: String
  var strMealThumb: String
  var idMeal: String
}
