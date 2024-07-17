//
//  FoodProductGridView.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 17.07.24.
//

import Foundation
import SwiftUI

struct FoodProductGridView : View {
    let products: Array<FoodProduct>
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: 
                    [
                        .init(.flexible(minimum: 50, maximum: 250), spacing: 25, alignment: .center),
                        .init(.flexible(minimum: 50, maximum: 250), spacing: 25, alignment: .center)
                    ],
                alignment: .center, spacing: 25
            ) {
                ForEach(products) { product in
                    FoodProductView(product: product)
                }
            }
        }
        .contentMargins(20, for: .scrollContent)
        .navigationTitle("Products")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FoodProductGridView(products: [
        .init(code: "", nutritionGrades: "A", productName: "Apple juice"),
        .init(code: "", nutritionGrades: "B", productName: "Apple juice"),
        .init(code: "", nutritionGrades: "D", productName: "Apple juice"),
        .init(code: "", nutritionGrades: "E", productName: "Apple juice"),
        .init(code: "", nutritionGrades: "C", productName: "Apple juice"),
        .init(code: "", nutritionGrades: "B", productName: "Apple juice"),
        .init(code: "", nutritionGrades: "A", productName: "Apple juice")
    ])
}
