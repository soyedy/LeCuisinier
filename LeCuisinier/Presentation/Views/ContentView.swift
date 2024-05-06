//
//  ContentView.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 19/04/24.
//

import SwiftUI
import SwiftData

struct FoodCategoryView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var items: [Item]
  @ObservedObject var viewModel: FoodViewModel
  
  private let gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
  
  var body: some View {
    NavigationView {
      ScrollView {
        LazyVGrid(columns: gridLayout) {
          ForEach($viewModel.categories, id: \.idCategory) { $category in
            VStack {
              AsyncImage(url: URL(string: category.strCategoryThumb)) { image in
                image.resizable()
              } placeholder: {
                ProgressView()
              }
              .frame(width: 120, height: 100)
              .background(Color.gray.opacity(0.2))
              .cornerRadius(10)
              
              Text(category.strCategory)
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.top, 8)
            }
            .padding()
            .cornerRadius(10)
          }
        }
        .background(Color(.systemBackground))
        .edgesIgnoringSafeArea(.all)
        .padding()
      }
      .navigationTitle("Explore categories")
      .navigationBarTitleDisplayMode(.large)
    }

    .onAppear {
      Task {
        await viewModel.fetchFoodCategories()
      }
    }
  }
}
