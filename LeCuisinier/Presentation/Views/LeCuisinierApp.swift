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
          let categoryService = FoodCategoryService()
          let categorySelectionService = FoodCategorySelection()
          let mealDetailService = FoodDetail()

          let foodServices = FoodServices(
              category: categoryService,
              selectCategory: categorySelectionService,
              selectMeal: mealDetailService
          )

          let localManager = LocalRepository()
          let remoteManager = RemoteRepository(foodServices: foodServices)
          let foodRepository = FoodRepository(
              localManager: localManager,
              remoteManager: remoteManager
          )

          let fetchCategoriesInteractor = FetchCategoriesInteractor(repository: foodRepository)
          let fetchSelectedCategoryInteractor = FetchSelectedCategory(repository: foodRepository)
          let fetchMealInteractor = FetchMealInteractor(repository: foodRepository)

          let foodInteractors = FoodInteractors(
              fetchCategories: fetchCategoriesInteractor,
              fetchSelectedCategory: fetchSelectedCategoryInteractor,
              fetchSelectedMeal: fetchMealInteractor
          )

          let foodViewModel = FoodViewModel(interactors: foodInteractors)

          ContentView(viewModel: foodViewModel)
          
        }
        .modelContainer(sharedModelContainer)
    }
}
