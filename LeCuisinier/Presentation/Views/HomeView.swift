//
//  ContentView.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 19/04/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var items: [Item]
  @ObservedObject var foodViewModel: FoodViewModel
  
  private let gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
  
  var body: some View {
    NavigationView {
      ScrollView {
        LazyVGrid(columns: gridLayout) {
          ForEach(foodViewModel.categories, id: \.idCategory) { category in
            NavigationLink(destination: MealsView(category: category, viewModel: foodViewModel)) {
              CategoryView(category: category)
            }
          }
        }
        .background(Color(.systemBackground))
        .edgesIgnoringSafeArea(.all)
        .padding()
      }
      .refreshable {
        Task {
          await foodViewModel.fetchFoodCategories()
        }
      }
      .navigationTitle("Explore categories")
      .navigationBarTitleDisplayMode(.large)
    }
    
    .onAppear {
      Task {
        await foodViewModel.fetchFoodCategories()
      }
    }
  }
}

struct MealsView: View {
  var category: FoodCategory
  var viewModel: FoodViewModel
  private let gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: gridLayout) {
        ForEach(viewModel.mealsBySelectedCategory, id: \.idMeal) { meal in
          VStack {
            AsyncImage(url: URL(string: meal.strMealThumb)) { image in
              image.resizable()
            } placeholder: {
              ProgressView()
            }
            .frame(width: 120, height: 120)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            
            Text(meal.strMeal)
              .font(.headline)
              .foregroundColor(.primary)
              .padding(.top, 8)
          }
          .padding()
          .cornerRadius(10)
        }
      }
      .navigationTitle("\(category.strCategory) dishes")
    }
    .onAppear {
      Task {
        await viewModel.fetchMeals(by: category)
      }
    }
  }
}
