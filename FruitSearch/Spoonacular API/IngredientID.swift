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
        default:
            return nil
        }
    }
}
