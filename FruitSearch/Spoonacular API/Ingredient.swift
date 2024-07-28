//
//  Ingredient.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 26.07.24.
//

import Foundation

struct Ingredient: Codable {
    var id: Int
    var original: String
    var originalName: String
    var name: String
    var amount: Double
    var unit: String
    var unitShort: String
    var unitLong: String
    var possibleUnits: Array<String>
    var estimatedCost: Cost
    var consistency: String
    var shoppingListUnits: Array<String>
    var aisle: String
    var image: String
//    var meta
    var nutrition: Nutrition
    var categoryPath: Array<String>
}

extension Ingredient {
    struct Cost: Codable {
        var value: Double
        var unit: String
    }
    
    struct Nutrition: Codable {
        var nutrients: Array<Nutrient>
        var properties: Array<NutritionProperty>
        var flavonoids: Array<Flavonoid>
        var caloricBreakdown: CaloricBreakdown
        var weightPerServing: WeightPerServing
    }
    
    struct Nutrient: Codable {
        var name: String
        var amount: Double
        var unit: String
        var percentOfDailyNeeds: Double
    }
    
    struct NutritionProperty: Codable {
        var name: String
        var amount: Double
        var unit: String
    }
    
    struct Flavonoid: Codable {
        var name: String
        var amount: Double
        var unit: String
    }
    
    struct CaloricBreakdown: Codable {
        var percentProtein: Double
        var percentFat: Double
        var percentCarbs: Double
    }
    
    struct WeightPerServing: Codable {
        var amount: Double
        var unit: String
    }
}

extension Ingredient.Nutrition {
    var protein: Ingredient.Nutrient {
        for nutrient in nutrients {
            if nutrient.name == "Protein" {
                return nutrient
            }
        }
        return .init(name: "Protein", amount: 0, unit: "g", percentOfDailyNeeds: 0)
    }
    
    var carbohydrate: Ingredient.Nutrient {
        for nutrient in nutrients {
            if nutrient.name == "Carbohydrates" {
                return nutrient
            }
        }
        return .init(name: "Carbohydrates", amount: 0, unit: "g", percentOfDailyNeeds: 0)
    }
    
    var fat: Ingredient.Nutrient {
        for nutrient in nutrients {
            if nutrient.name == "Fat" {
                return nutrient
            }
        }
        return .init(name: "Fat", amount: 0, unit: "g", percentOfDailyNeeds: 0)
    }
    
    var calories: Ingredient.Nutrient {
        for nutrient in nutrients {
            if nutrient.name == "Calories" {
                return nutrient
            }
        }
        return .init(name: "Calories", amount: 0, unit: "kcal", percentOfDailyNeeds: 0)
    }
}

extension Ingredient.Nutrient {
    func transform(from currentServing: Ingredient.WeightPerServing, to newServing: Ingredient.WeightPerServing) -> Self {
        return .init(name: self.name, amount: (self.amount / currentServing.amount) * newServing.amount, unit: self.unit, percentOfDailyNeeds: (self.percentOfDailyNeeds / currentServing.amount) * newServing.amount)
    }
}

extension Ingredient.WeightPerServing: Hashable {
    static var hundredGramm: Self {
        .init(amount: 100, unit: "g")
    }
    
    func with(amount: Double) -> Self {
        .init(amount: amount, unit: self.unit)
    }
}
