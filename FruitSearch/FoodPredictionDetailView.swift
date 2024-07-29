//
//  FoodProductGridView.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 17.07.24.
//

import Foundation
import SwiftUI

struct FoodPredictionDetailView : View {
    let prediction: FoodPrediction
    
    @State var ingredient: Ingredient? = nil
    @State var loadingError: Bool = false
    
    @Environment(\.dismiss) var dismissAction
    
    init(prediction: FoodPrediction) {
        self.prediction = prediction
    }
    
    var body: some View {
        ZStack {
            Color.clear
            
            if let ingredient {
                IngredientView(image: prediction.source, ingredient: ingredient)
            }else {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
//        .background(Gradient(colors: [.accentColor.opacity(0.5), .clear, .clear, .clear]))
        .background(ignoresSafeAreaEdges: .all)
        .alert("Loading failed!", isPresented: $loadingError) {
            Button {
                dismissAction.callAsFunction()
            } label: {
                Text("Ok")
            }
        }
        .task {
            let service = SpoonacularService()
            do {
                if let id = IngredientID.get(of: prediction.name) {
                    ingredient = try await service.getIngredient(id: id)
                }else {
                    print("Invalid IngredientID")
                    loadingError = true
                }
            }catch {
                print(error)
            }
        }
    }
}


