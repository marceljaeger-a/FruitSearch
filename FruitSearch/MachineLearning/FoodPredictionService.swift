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
    func predictFruit(in image: Image) async throws -> FoodPrediction? {
        let renderer = ImageRenderer(content: image)
        guard let cgImage = renderer.cgImage else {
            throw FoodPredictionError.invalidImage
        }
        
        do {
            let config = MLModelConfiguration()
            let model = try FruitDiscover(configuration: config)
            let input = try FruitDiscoverInput(imageWith: cgImage)
            let output = try await model.prediction(input: input)
            
            let target = output.target
            let predictions = output.targetProbability
            let probability = predictions[target]
            guard let probability, probability > 0.8 else {
                print(probability?.description)
                return nil
            }
        
            return .init(rawValue: target)
        } catch {
            throw FoodPredictionError.failedPrediction
        }
    }
}
