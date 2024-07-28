//
//  IngredientId.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 26.07.24.
//

import Foundation

struct IngredientID: Codable {
    var value: Int
    
    static func get(of name: String) -> Self? {
        switch name {
        case "Apple":
            return .init(value: 9003)
        case "Banana":
            return .init(value: 9040)
        case "Orange":
            return .init(value: 9200)
        case "Tomato":
            return .init(value: 11529)
        default:
            return nil
        }
    }
}
