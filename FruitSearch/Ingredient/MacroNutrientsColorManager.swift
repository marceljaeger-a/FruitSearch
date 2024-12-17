//
//  struct.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 30.07.24.
//

import Foundation
import SwiftUI

struct MacroNutrientsColorManager {
    static func style(of nutrient: Ingredient.Nutrient, in allNutrients: Array<Ingredient.Nutrient>) -> AnyShapeStyle {
        let sortedNutrients = allNutrients.sorted(using: KeyPathComparator(\.amount, order: .reverse))
        
        var counter = 0
        for nutrientItem in sortedNutrients {
            if nutrient.name == nutrientItem.name {
                break
            }
            counter += 1
        }
        
        switch counter {
        case 0:
            return AnyShapeStyle(.accent)
        case 1:
            return AnyShapeStyle(.secondAccent)
        default:
            return AnyShapeStyle(.thirdAccent)
        }
    }
}
