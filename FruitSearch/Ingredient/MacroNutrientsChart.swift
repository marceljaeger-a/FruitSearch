//
//  MakroNutrientsChart.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 26.07.24.
//

import Foundation
import SwiftUI
import Charts

struct MacroNutrientsChart: View {
    let protein: Ingredient.Nutrient
    let carbs:  Ingredient.Nutrient
    let fat:  Ingredient.Nutrient
    
    var body: some View {
        Chart {
            SectorMark(angle: .value("Protein", protein.amount), innerRadius: .ratio(0.6), angularInset: 2)
                .foregroundStyle(MacroNutrientsColorManager.style(of: protein, in: [protein, carbs, fat]))
                .cornerRadius(10)
            
            SectorMark(angle: .value("Carbs", carbs.amount), innerRadius: .ratio(0.6), angularInset: 2)
                .foregroundStyle(MacroNutrientsColorManager.style(of: carbs, in: [protein, carbs, fat]))
                .cornerRadius(10)
            
            SectorMark(angle: .value("Fat", fat.amount), innerRadius: .ratio(0.6), angularInset: 2)
                .foregroundStyle(MacroNutrientsColorManager.style(of: fat, in: [protein, carbs, fat]))
                .cornerRadius(10)
        }
    }
}
