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
    
    @State var products: Array<FoodProduct> = []
    
    @State var loadingError: Bool = false
    
    private func loadFoodPruducts() async {
        do {
            let service = OpenFoodFactsService()

            let searchingKeyWord: String = { () -> String in
                if prediction.name == "Tomato" {
                    return "Tomaten"
                }else if prediction.name == "Banana" {
                    return "Banane"
                } else {
                    return prediction.name
                }
            }()

            let list = try await service.fetchList(searchBy: searchingKeyWord)
            products = list.products
        }catch OpenFoodFactsError.invalidURL {
            print("Invalid URL")
            loadingError = true
        } catch OpenFoodFactsError.invalidRespsone {
            print("Invalid Response")
            loadingError = true
        } catch OpenFoodFactsError.invlaidData {
            print("Invalid Data")
            loadingError = true
        } catch {
            print("Unknown Error")
            loadingError = true
        }
    }
    
    var body: some View {
        ScrollView {
            NutrientsView(nutrients: prediction.nutrients)
            
            Section {
                if products.isEmpty == false {
                    FoodProductsGridView(products: products)
                } else if loadingError {
                    ContentUnavailableView("Loading products failed!", systemImage: "exclamationmark.triangle")
                } else {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            } header: {
                HStack {
                    Text("Products")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                }
            }
        }
        .contentMargins(20, for: .scrollContent)
        .navigationTitle(prediction.name)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await loadFoodPruducts()
        }
    }
}

#Preview {
    FoodPredictionDetailView(prediction: .init(name: "Apple", nutrients: .apple), products: [], loadingError: false)
}
