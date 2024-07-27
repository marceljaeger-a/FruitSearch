//
//  MakroNutrientsView.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 26.07.24.
//

import Foundation
import SwiftUI

struct NutritionOverviewView: View {
    let nutrition: Ingredient.Nutrition
    
    var nutrients: Array<Ingredient.Nutrient> {
        if let calories = nutrition.calories, let protein = nutrition.protein, let carbohydrate = nutrition.carbohydrate, let fat = nutrition.fat {
            return [calories, protein, carbohydrate, fat]
        }
        return []
    }
    
    var proteinNutrient: Ingredient.Nutrient {
        nutrition.protein ?? .init(name: "Protein", amount: 0, unit: "g", percentOfDailyNeeds: 0)
    }
    
    var carbsNutrient: Ingredient.Nutrient {
        nutrition.carbohydrate ?? .init(name: "Carbs", amount: 0, unit: "g", percentOfDailyNeeds: 0)
    }
    
    var fatNutrient: Ingredient.Nutrient {
        nutrition.fat ?? .init(name: "Fat", amount: 0, unit: "g", percentOfDailyNeeds: 0)
    }
    
    var body: some View {
        MakroNutrientsChart(protein: proteinNutrient, carbs: carbsNutrient, fat: fatNutrient)
    }
}
