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
    
    var proteinColor: AnyShapeStyle{
        let sortedNutrients = [protein, carbs, fat].sorted(using: KeyPathComparator(\.amount))
        
        var counter = 0
        for nutrient in sortedNutrients {
            if protein.name == nutrient.name {
                break
            }
            counter += 1
        }
        
        switch counter {
        case 0:
            return AnyShapeStyle(.accent.gradient)
        case 1:
            return AnyShapeStyle(.secondAccent.gradient)
        default:
            return AnyShapeStyle(.thirdAccent.gradient)
        }
    }
    
    var carbsColor: AnyShapeStyle{
        let sortedNutrients = [protein, carbs, fat].sorted(using: KeyPathComparator(\.amount, order: .reverse))
    
        var counter = 0
        for nutrient in sortedNutrients {
            if carbs.name == nutrient.name {
                break
            }
            counter += 1
        }
        
        switch counter {
        case 0:
            return AnyShapeStyle(.accent.gradient)
        case 1:
            return AnyShapeStyle(.secondAccent.gradient)
        default:
            return AnyShapeStyle(.thirdAccent.gradient)
        }
    }
    
    var fatColor: AnyShapeStyle{
        let sortedNutrients = [protein, carbs, fat].sorted(using: KeyPathComparator(\.amount, order: .reverse))
        
        var counter = 0
        for nutrient in sortedNutrients {
            if fat.name == nutrient.name {
                break
            }
            counter += 1
        }
        
        switch counter {
        case 0:
            return AnyShapeStyle(.accent.gradient)
        case 1:
            return AnyShapeStyle(.secondAccent.gradient)
        default:
            return AnyShapeStyle(.thirdAccent.gradient)
        }
    }
    
    var body: some View {
        Chart {
            SectorMark(angle: .value("Protein", protein.amount), innerRadius: .ratio(0.6), angularInset: 2)
                .foregroundStyle(proteinColor)
                .cornerRadius(10)
            
            SectorMark(angle: .value("Carbs", carbs.amount), innerRadius: .ratio(0.6), angularInset: 2)
                .foregroundStyle(carbsColor)
                .cornerRadius(10)
            
            SectorMark(angle: .value("Fat", fat.amount), innerRadius: .ratio(0.6), angularInset: 2)
                .foregroundStyle(fatColor)
                .cornerRadius(10)
        }
    }
}
