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
        LazyVGrid(columns: [GridItem(alignment: .leading), GridItem(alignment: .leading)], spacing: 15) {
            ForEach(nutrients, id: \.name) { nutrient in
                NutrientGridItem(nutrient: nutrient)
            }
        }
        .padding()
    }
}

extension NutrientListView {
    struct NutrientGridItem: View {
        let nutrient: Ingredient.Nutrient
        
        var body: some View {
            Text("\(nutrient.amount.formatted())\(nutrient.unit)")
                .font(.callout)
            Text(nutrient.name)
                .font(.callout)
                .foregroundStyle(.secondary)
        }
    }
}
