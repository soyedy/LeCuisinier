//
//  LocalRepository.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 24/04/24.
//

import Foundation

protocol LocalRepositoryProtocol {
  func fetchFoodCategories()
}

struct LocalRepository: LocalRepositoryProtocol {
  func fetchFoodCategories() {
    print("Fetching Data locally ...")
  }
}
