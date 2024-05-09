//
//  FoodCategoryView.swift
//  LeCuisinier
//
//  Created by John Edward Narvaez Londono on 8/05/24.
//

import SwiftUI

struct CategoryView: View {
  var category: FoodCategory
  
  var body: some View {
    VStack {
      AsyncImage(url: URL(string: category.strCategoryThumb)) { image in
        image.resizable()
      } placeholder: {
        ProgressView()
      }
      .frame(width: 120, height: 120)
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
