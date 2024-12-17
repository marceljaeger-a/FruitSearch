//
//  NutrientsListView.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 26.07.24.
//

import Foundation
import SwiftUI

struct NutrientListView: View {
    let nutrients: Array<Ingredient.Nutrient>
    
    var body: some View {
//        LazyVStack(spacing: 5) {
            ForEach(nutrients, id: \.name) { nutrient in
                NutrientGridItem(nutrient: nutrient)
            }
//        }
//        .padding()
    }
}

extension NutrientListView {
    struct NutrientGridItem: View {
        let nutrient: Ingredient.Nutrient
        
        var body: some View {
            HStack {
                Text(nutrient.name)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Text("\(nutrient.amount.nutrientFormatted())\(nutrient.unit)")
            }
        }
    }
}
