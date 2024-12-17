//
//  FoodProduct.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 16.07.24.
//

import Foundation
import SwiftUI

struct FoodProduct: Codable, Identifiable, Hashable {
    let id = UUID()
    
    var code: String
    var nutritionGrades: String
    var productName: String
    
    var formattedNutriScore: String {
        let validGrades = ["A", "B", "C", "D", "E"]
        if validGrades.contains { $0 == nutritionGrades.uppercased() } {
            return nutritionGrades.uppercased()
        }else {
            return "?"
        }
    }
}

extension FoodProduct {
    var imageURL: URL? {
        if code.count == 8 {
            return URL(string: "https://images.openfoodfacts.org/images/products/\(code)/1.jpg")
        }else if code.count > 8 {
            var code = code
            let firstPart = [code.removeFirst(), code.removeFirst(), code.removeFirst()].reduce("", { "\($0)\($1)" })
            let secondPart = [code.removeFirst(), code.removeFirst(), code.removeFirst()].reduce("", { "\($0)\($1)" })
            let thirdPart = [code.removeFirst(), code.removeFirst(), code.removeFirst()].reduce("", { "\($0)\($1)" })
            let lastPart = code
            
            let resultCode = "\(firstPart)/\(secondPart)/\(thirdPart)/\(lastPart)"
            
            return URL(string: "https://images.openfoodfacts.org/images/products/\(resultCode)/1.jpg")
        }else {
            return nil
        }
    }
    
    var nutritionGradesColor: Color {
        switch nutritionGrades.uppercased() {
        case "A":
            .green
        case "B":
            .green
        case "C":
            .yellow
        case "D":
            .orange
        case "E":
            .red
        default:
            .secondary
        }
    }
}
