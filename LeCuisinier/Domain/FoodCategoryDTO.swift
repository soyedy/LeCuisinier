//
//  FoodCategoryDTO.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 25/04/24.
//

import Foundation
import SwiftUI

struct FoodCategory: Codable {
  var idCategory: UUID
  var strCategory: String
  var strCategoryThumb: URL
  var strCategoryDescription: String
}
