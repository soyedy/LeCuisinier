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
          ContentView(
            viewModel:
              FoodViewModel(
                useCases: 
                  FoodUseCases(
                    fetchCategories: 
                      FetchCategoriesEntity(
                        repository:
                          FoodRepository(
                            localManager: LocalRepository(), 
                            remoteManager: RemoteRepository(
                              foodServices: FoodServices(category: FoodCategoryService())))))))
        }
        .modelContainer(sharedModelContainer)
    }
}
