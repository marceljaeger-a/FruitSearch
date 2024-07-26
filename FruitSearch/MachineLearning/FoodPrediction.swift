//
//  FoodPrediction.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 22.07.24.
//

import Foundation

struct FoodPrediction: Hashable {
    var name: String
    var nutrients: Nutrients
}

extension FoodPrediction: RawRepresentable  {
    init?(rawValue: String) {
        switch rawValue {
        case "Apple":
            self.init(name: rawValue, nutrients: .apple)
        case "Banana":
            self.init(name: rawValue, nutrients: .banana)
        case "Orange":
            self.init(name: rawValue, nutrients: .orange)
        case "Tomato":
            self.init(name: rawValue, nutrients: .tomato)
        default:
            return nil
        }
    }
    
    var rawValue: String {
        self.name
    }
    
    typealias RawValue = String
}

struct Nutrients: Hashable {
    var calories: Double
    var protein: Double
    var fat: Double
    var saturatedFat: Double
    var unsaturatedFat: Double
    var carbs: Double
    var fibres: Double
    var sugar: Double
    
    var cholesterol: Double = 0
    var sodium: Double = 0
    var salt: Double = 0
    var water: Double = 0
    var alcohol: Double = 0
    
    var vitaminA: Double = 0
    var vitaminB1: Double = 0
    var vitaminB11: Double = 0
    var vitaminB12: Double = 0
    var vitaminB2: Double = 0
    var vitaminB3: Double = 0
    var vitaminB5: Double = 0
    var vitaminB6: Double = 0
    var vitaminB7: Double = 0
    var vitaminC: Double = 0
    var vitaminD: Double = 0
    var vitaminE: Double = 0
    var vitaminK: Double = 0
    
    var calcium: Double = 0
    var chloride: Double = 0
    var copper: Double = 0
    var fluorine: Double = 0
    var iodine: Double = 0
    var iron: Double = 0
    var magnesium: Double = 0
    var manganese: Double = 0
    var phosphorus: Double = 0
    var potassium: Double = 0
    var sulfur: Double = 0
    var zinc: Double = 0
    
    var all: Array<(String, Double)> {
        [
            ("protein", protein),
            ("fat", fat),
            ("saturated fat", saturatedFat),
            ("unsaturated fat", unsaturatedFat),
            ("carbs", carbs),
            ("fibres", fibres),
            ("sugar", sugar),
            ("cholesterol", cholesterol),
            ("sodium", sodium),
            ("salt", salt),
            ("water", water),
            ("alcohol", alcohol),
            ("vitamin A", vitaminA),
            ("vitamim B1", vitaminB1),
            ("vitamin B3", vitaminB3),
            ("vitamin B5", vitaminB5),
            ("vitamin B6", vitaminB6),
            ("vitamin B7", vitaminB7),
            ("vitamin C", vitaminC),
            ("vitamin D", vitaminD),
            ("vitamin E", vitaminE),
            ("vitamin K", vitaminK),
            ("calcium", calcium),
            ("chloride", chloride),
            ("copper", copper),
            ("fluorine", fluorine),
            ("iodine", iodine),
            ("iron", iron),
            ("maagnesium", magnesium),
            ("phosphorus", phosphorus),
            ("potassium", potassium),
            ("sulfur", sulfur),
            ("zinc", zinc)
        ]
    }
}

extension Nutrients {
    static let apple: Self = .init(calories: 52, protein: 0.3, fat: 0.2, saturatedFat: 0, unsaturatedFat: 0, carbs: 14, fibres: 2.4, sugar: 10)
    static let banana: Self = .init(calories: 0, protein: 0, fat: 0, saturatedFat: 0, unsaturatedFat: 0, carbs: 0, fibres: 0, sugar: 0)
    static let orange: Self = .init(calories: 0, protein: 0, fat: 0, saturatedFat: 0, unsaturatedFat: 0, carbs: 0, fibres: 0, sugar: 0)
    static let tomato: Self = .init(calories: 0, protein: 0, fat: 0, saturatedFat: 0, unsaturatedFat: 0, carbs: 0, fibres: 0, sugar: 0)
}

