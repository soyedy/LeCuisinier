//
//  FoodViewModel.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 25/04/24.
//

import Foundation
import SwiftUI

protocol FoodUseCasesProtocol {
  var fetchCategories: FetchCategoriesProtocol { get }
}

struct FoodUseCases: FoodUseCasesProtocol {
  var fetchCategories: FetchCategoriesProtocol
}

protocol FoodViewModelProtocol: ObservableObject {
  var useCases: FoodUseCasesProtocol { get }
  func fetchFoodCategories() async
}

class FoodViewModel: FoodViewModelProtocol {
  var useCases: FoodUseCasesProtocol
  @Published var categories: [FoodCategory] = []
  
  init(useCases: FoodUseCasesProtocol) {
    self.useCases = useCases
  }
  
  func fetchFoodCategories() async {
    do {
      let fetchedCategories = try await useCases.fetchCategories.execute()
      await MainActor.run {
        self.categories = fetchedCategories
      }
    } catch {
      
    }
  }
  
}
