//
//  LeCuisinierApp.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 19/04/24.
//

import SwiftUI
import SwiftData

@main
struct LeCuisinierApp: App {
  
  let categoryService = FoodCategoryService()
  let categorySelectionService = FoodCategorySelection()
  let mealDetailService = FoodDetail()
  
  let foodServices: FoodServices
  let localManager: LocalRepository
  let remoteManager: RemoteRepository
  let foodRepository: FoodRepository
  
  let fetchCategoriesInteractor: FetchCategoriesInteractor
  let fetchSelectedCategoryInteractor: FetchSelectedCategory
  let fetchMealInteractor: FetchMealInteractor
  
  let foodInteractors: FoodInteractors
  let foodViewModel: FoodViewModel
  
  init() {
    foodServices = FoodServices(
      category: categoryService,
      selectCategory: categorySelectionService,
      selectMeal: mealDetailService
    )
    
    localManager = LocalRepository()
    remoteManager = RemoteRepository(foodServices: foodServices)
    foodRepository = FoodRepository(
      localManager: localManager,
      remoteManager: remoteManager
    )
    
    fetchCategoriesInteractor = FetchCategoriesInteractor(repository: foodRepository)
    fetchSelectedCategoryInteractor = FetchSelectedCategory(repository: foodRepository)
    fetchMealInteractor = FetchMealInteractor(repository: foodRepository)
    
    foodInteractors = FoodInteractors(
      fetchCategories: fetchCategoriesInteractor,
      fetchSelectedCategory: fetchSelectedCategoryInteractor,
      fetchSelectedMeal: fetchMealInteractor
    )
    
    foodViewModel = FoodViewModel(interactors: foodInteractors)
  }
  
  var sharedModelContainer: ModelContainer = {
    let schema = Schema([
      Item.self,
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    
    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()
  
  var body: some Scene {
    WindowGroup {
      FoodCategoryView(viewModel: foodViewModel)
    }
    .modelContainer(sharedModelContainer)
  }
}
