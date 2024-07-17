//
//  FoodProductView.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 17.07.24.
//

import Foundation
import SwiftUI

struct FoodProductView : View {
    let product: FoodProduct
    
    var body: some View {
        AsyncImage(url: product.imageURL) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            Color.secondary
                .overlay {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
        }
        .frame(width: 150, height: 150)
        .overlay(alignment: .bottom) {
            HStack {
                Text(product.productName)
                    .lineLimit(1, reservesSpace: true)
                    .font(.caption)
                
                Spacer()
                
                Text(product.formattedNutriScore)
                    .font(.title3)
                    .lineLimit(1)
                    .fontDesign(.monospaced)
                    .bold()
                    .foregroundStyle(product.nutritionGradesColor.gradient)
            }
            .padding(12)
            .background(.ultraThinMaterial, in: .rect)
        }
        .clipShape(.buttonBorder)
        .background(.background.shadow(.drop(radius: 2)), in: .buttonBorder)
            
    }
}


#Preview {
    VStack {
        FoodProductView(product: .init(code: "", nutritionGrades: "A", productName: "Apple shape"))
        FoodProductView(product: .init(code: "", nutritionGrades: "B", productName: "Apple shape"))
        FoodProductView(product: .init(code: "", nutritionGrades: "C", productName: "Apple shape"))
        FoodProductView(product: .init(code: "", nutritionGrades: "D", productName: "Apple shape"))
        FoodProductView(product: .init(code: "", nutritionGrades: "E", productName: "Apple shape"))
    }
}
