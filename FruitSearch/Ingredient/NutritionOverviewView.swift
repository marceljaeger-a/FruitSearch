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
    
    var body: some View {
        MakroNutrientsChart(protein: nutrition.protein, carbs: nutrition.carbohydrate, fat: nutrition.fat)
    }
}
