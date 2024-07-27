//
//  FoodPredictionNutrientsView.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 24.07.24.
//

import Foundation
import SwiftUI
import Charts

struct NutritionView: View {
    
    //MARK: - Dependencies
    
    let nutrition: Ingredient.Nutrition
    let fruitImage: Image
    
    //MARK: - Methods

    
    //MARK: - Body
    
    var body: some View {
        VStack(spacing: 25) {
            GroupBox("Serving") {
                HStack(spacing: 25) {
                    fruitImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100)
                        .clipShape(.buttonBorder)
                    
                    VStack(alignment: .leading) {
                        Text("\(nutrition.weightPerServing.amount.formatted()) \(nutrition.weightPerServing.unit)")
    
                        Text("\((nutrition.calories?.amount ?? 0).formatted()) \(nutrition.calories?.unit ?? "kcal")")
                    }
                    
                    Spacer()
                }
            }
            .backgroundStyle(.ultraThinMaterial)
            
            GroupBox("Makro nutrients") {
                NutritionOverviewView(nutrition: nutrition)
            }
            .backgroundStyle(.ultraThinMaterial)
            
            GroupBox("All nutrients") {
                NutrientListView(nutrients: nutrition.nutrients.sorted(using: KeyPathComparator(\.name)).filter { ["Calories"].contains($0.name) == false })
            }
            .backgroundStyle(.ultraThinMaterial)
        }
    }
}






