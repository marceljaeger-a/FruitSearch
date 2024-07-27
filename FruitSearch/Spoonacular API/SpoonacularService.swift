//
//  SpoonacularService.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 26.07.24.
//

import Foundation

struct SpoonacularService {
    static private let apiKey: String = "ec635c7b6c3645eebcdcb2e28cea5698"
    
    func getIngredient(id: IngredientID) async throws -> Ingredient {
        let url = URL(string: "https://api.spoonacular.com/food/ingredients/\(id.value)/information?apiKey=\(Self.apiKey)&amount=1")
        guard let url else { throw SpoonacularError.invalidURL }
        guard let response = try? await URLSession.shared.data(from: url), let httpResponse = response.1 as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw SpoonacularError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        let data = try? decoder.decode(Ingredient.self, from: response.0)
        guard let data else {
            throw SpoonacularError.invalidData
        }
        
        return data
    }
}
