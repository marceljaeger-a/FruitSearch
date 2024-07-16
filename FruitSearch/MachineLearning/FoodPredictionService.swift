//
//  FootPredictionService.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 16.07.24.
//

import Foundation
import CoreML
import SwiftUI

struct FoodPredictionService {
    @MainActor 
    func predictFruit(in image: Image) throws -> String {
        let renderer = ImageRenderer(content: image)
        guard let cgImage = renderer.cgImage else {
            throw FoodPredictionError.invalidImage
        }
        
        do {
            let config = MLModelConfiguration()
            let model = try FruitDiscover(configuration: config)
         
            let input = try FruitDiscoverInput(imageWith: cgImage)
            let output = try model.prediction(input: input)
            
            return output.target
        } catch {
            throw FoodPredictionError.failedPrediction
        }
    }
}
