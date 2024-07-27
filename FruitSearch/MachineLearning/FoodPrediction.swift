//
//  FoodPrediction.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 22.07.24.
//

import Foundation
import SwiftUI

struct FoodPrediction: Hashable {
    var name: String
    let source: Image
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

extension FoodPrediction {
    init?(rawValue: String, source: Image) {
        switch rawValue {
        case "Apple":
            self.init(name: rawValue, source: source)
        case "Banana":
            self.init(name: rawValue, source: source)
        case "Orange":
            self.init(name: rawValue, source: source)
        case "Tomato":
            self.init(name: rawValue, source: source)
        default:
            return nil
        }
    }
}


