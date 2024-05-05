//
//  FoodViewModel.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 25/04/24.
//

import Foundation
import SwiftUI

protocol FoodViewModelProtocol: ObservableObject {
  var interactors: FoodInteractorsProtocol { get }
  func fetchFoodCategories() async
}

class FoodViewModel: FoodViewModelProtocol {
  var interactors: FoodInteractorsProtocol
  @Published var categories: [FoodCategory] = []
  
  init(interactors: FoodInteractorsProtocol) {
    self.interactors = interactors
  }
  
  func fetchFoodCategories() async {
    do {
      let fetchedCategories = try await interactors.fetchCategories.execute()
      await MainActor.run {
        self.categories = fetchedCategories
      }
    } catch {
      
    }
  }
  
}
