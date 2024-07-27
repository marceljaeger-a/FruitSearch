//
//  MakroNutrientsChart.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 26.07.24.
//

import Foundation
import SwiftUI
import Charts

struct MakroNutrientsChart: View {
    let protein: Ingredient.Nutrient
    let carbs:  Ingredient.Nutrient
    let fat:  Ingredient.Nutrient
    
    var body: some View {
        Chart {
            SectorMark(angle: .value("Protein", protein.amount), innerRadius: .ratio(0.5), angularInset: 0.5)
                .foregroundStyle(by: .value("Nutrient", "\(protein.amount.formatted()) \(protein.unit) Protein"))
                .cornerRadius(10)
            
            SectorMark(angle: .value("Carbs", carbs.amount), innerRadius: .ratio(0.5), angularInset: 0.5)
                .foregroundStyle(by: .value("Nutrient", "\(carbs.amount.formatted()) \(carbs.unit) Carbs"))
                .cornerRadius(10)
            
            SectorMark(angle: .value("Fat", fat.amount), innerRadius: .ratio(0.5), angularInset: 0.5)
                .foregroundStyle(by: .value("Nutrient", "\(fat.amount.formatted()) \(fat.unit) Fat"))
                .cornerRadius(10)
        }
        .chartLegend(.visible)
        .chartLegend(position: .bottom, alignment: .center, spacing: 30)
        .font(.headline)
        .scaledToFit()
        .padding()
    }
}
