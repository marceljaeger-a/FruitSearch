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
    
    @State var selectedPortion: Ingredient.WeightPerServing
    
    init(image: Image, ingredient: Ingredient) {
        self.image = image
        self.ingredient = ingredient
        self.selectedPortion = ingredient.nutrition.weightPerServing
    }
    
    var body: some View {
        Form {
            ingredientImageSection
            ingredientServingSection
            ingredientMacroNutrientsSection
            ingredientNutrientsSection
        }
    }
    
    var ingredientImageSection: some View {
        Section {
            HStack {
                Spacer()
                VStack {
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(.buttonBorder)
                        .shadow(radius: 3)
                        .containerRelativeFrame(.horizontal, count: 2, span: 1, spacing: 0)
                    
                    Text(ingredient.name.uppercasedFirst())
                        .font(.largeTitle)
                        .bold()
                }
                Spacer()
            }
        }
        .listRowBackground(Color.clear)
    }
    
    var ingredientServingSection: some View {
        Section("Serving") {
            Picker("Amount", selection: $selectedPortion) {
                Text("\(ingredient.nutrition.weightPerServing.amount.nutrientFormatted()) \(ingredient.nutrition.weightPerServing.unit)")
                    .tag(ingredient.nutrition.weightPerServing)
                
                if ingredient.nutrition.weightPerServing.amount != 100 {
                    Text("100 g")
                        .tag(ingredient.nutrition.weightPerServing.with(amount: 100))
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    
    var ingredientMacroNutrientsSection: some View {
        Section("Macros") {
            HStack {
                MacroNutrientsChart(
                    protein: ingredient.nutrition.protein.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion),
                    carbs: ingredient.nutrition.carbohydrate.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion),
                    fat: ingredient.nutrition.fat.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion)
                )
                .scaledToFit()
                .containerRelativeFrame(.horizontal, count: 2, span: 1, spacing: 0)
                .overlay {
                    VStack {
                        Text("\(ingredient.nutrition.calories.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion).amount.formatted())")
                            .bold()
                        Text("\(ingredient.nutrition.calories.unit)")
                    }
                }
                
                Spacer()
                
                VStack(spacing: 10) {
                    VStack {
                        Text("Protein")
                            .foregroundStyle(MacroNutrientsColorManager.style(of: ingredient.nutrition.protein, in: [ingredient.nutrition.protein, ingredient.nutrition.carbohydrate, ingredient.nutrition.fat]))
                        Text("\(ingredient.nutrition.protein.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion).amount.nutrientFormatted())\(ingredient.nutrition.protein.unit)")
                            .bold()
                    }
                    
                    VStack {
                        Text("Carbs")
                            .foregroundStyle(MacroNutrientsColorManager.style(of: ingredient.nutrition.carbohydrate, in: [ingredient.nutrition.protein, ingredient.nutrition.carbohydrate, ingredient.nutrition.fat]))
                        Text("\(ingredient.nutrition.carbohydrate.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion).amount.nutrientFormatted())\(ingredient.nutrition.carbohydrate.unit)")
                            .bold()
                    }
                    
                    VStack {
                        Text("Fat")
                            .foregroundStyle(MacroNutrientsColorManager.style(of: ingredient.nutrition.fat, in: [ingredient.nutrition.protein, ingredient.nutrition.carbohydrate, ingredient.nutrition.fat]))
                        Text("\(ingredient.nutrition.fat.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion).amount.nutrientFormatted())\(ingredient.nutrition.fat.unit)")
                            .bold()
                    }
                }
                
                Spacer()
            }
        }
    }
    
    var ingredientNutrientsSection: some View {
        Section("Nutrients") {
            NutrientListView(nutrients: ingredient.nutrition.nutrients.filter { $0.name != "Calories" }.sorted(using: KeyPathComparator(\.name)).map{ $0.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion) })
        }
    }
}




