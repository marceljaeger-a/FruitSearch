//
//  IngredientView.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 27.07.24.
//

import Foundation
import SwiftUI

struct IngredientView: View {
    let image: Image
    let ingredient: Ingredient
    
    @State var selectedPortion: Double = 150
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                
                GroupBox("") {
                    HStack {
                        image
                            .resizable()
                            .scaledToFill()
                            .containerRelativeFrame(.horizontal, count: 2, span: 1, spacing: 0)
                            .clipShape(.rect(cornerRadius: 10))
                            .shadow(radius: 3)
                        
                        Picker("", selection: $selectedPortion) {
                            Text("\(ingredient.nutrition.weightPerServing.amount.formatted()) \(ingredient.nutrition.weightPerServing.unit)").tag(ingredient.nutrition.weightPerServing.amount)
                            
                            if ingredient.nutrition.weightPerServing.amount != 100 {
                                Text("100 g")
                                    .tag(100)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 125)
                    }
                }
                .backgroundStyle(.regularMaterial)
                .padding(10)
                .containerRelativeFrame(.horizontal, count: 2, span: 2, spacing: 0)
                
                GroupBox("Macros") {
                    MakroNutrientsChart(protein: ingredient.nutrition.protein, carbs: ingredient.nutrition.carbohydrate, fat: ingredient.nutrition.fat)
                        .scaledToFit()
                        .shadow(radius: 3)
                        .containerRelativeFrame(.horizontal, count: 2, span: 1, spacing: 0)
                        .overlay {
                            VStack {
                                Text("\(ingredient.nutrition.calories.amount.formatted())")
                                    .bold()
                                Text("\(ingredient.nutrition.calories.unit)")
                            }
                        }
                    
                    Spacer(minLength: 25)
                    
                    Grid(horizontalSpacing: 25) {
                        GridRow {
                            Text("Protein")
                                .foregroundStyle(.blue)
                            
                            Text("Carbs")
                                .foregroundStyle(.green)
                                .bold()
                            
                            Text("Fat")
                                .foregroundStyle(.orange)
                        }
                        GridRow {
                            Text("\(ingredient.nutrition.protein.amount.formatted())\(ingredient.nutrition.protein.unit)")
                                .foregroundStyle(.blue)
                                .bold()
                            
                            Text("\(ingredient.nutrition.carbohydrate.amount.formatted())\(ingredient.nutrition.carbohydrate.unit)")
                                .foregroundStyle(.green)
                                .bold()
                            
                            Text("\(ingredient.nutrition.fat.amount.formatted())\(ingredient.nutrition.fat.unit)")
                                .foregroundStyle(.orange)
                                .bold()
                        }
                    }
                    
                        
                        
                }
                .backgroundStyle(.regularMaterial)
                .padding(10)
                .containerRelativeFrame(.horizontal, count: 2, span: 2, spacing: 0)
                
                GroupBox("Nutrients") {
                    NutrientListView(nutrients: ingredient.nutrition.nutrients)
                }
                .backgroundStyle(.regularMaterial)
                .padding(10)
                .containerRelativeFrame(.horizontal, count: 2, span: 2, spacing: 0)
                

            }
        }
        .contentMargins(20)
    }
}


#Preview {
    IngredientView(image: .init(systemName: "cup.and.saucer.fill"), ingredient: .init(id: 0, original: "", originalName: "", name: "Apple", amount: 1, unit: "piece", unitShort: "p", unitLong: "piece", possibleUnits: [], estimatedCost: .init(value: 20, unit: "euroe"), consistency: "", shoppingListUnits: [], aisle: "", image: "", nutrition: .init(nutrients: [], properties: [], flavonoids: [], caloricBreakdown: .init(percentProtein: 30, percentFat: 30, percentCarbs: 40), weightPerServing: .init(amount: 150, unit: "g")), categoryPath: []))
}
