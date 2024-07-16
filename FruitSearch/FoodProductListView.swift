//
//  FoodProductListView.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 16.07.24.
//

import Foundation
import SwiftUI

struct FoodProductListView: View {
    let list: FoodProductList?
    
    var body: some View {
        List(list?.products ?? []) { product in
            HStack {
                AsyncImage(url: product.imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .fill(.tertiary)
                        .frame(width: 50, height: 50)
                        .overlay {
                            ProgressView()
                                .progressViewStyle(.circular)
                        }
                }
                
                
                VStack(alignment: .leading) {
                    Text(product.productName)
                        .font(.headline)
                    
                    Text("Nutri-Score " + product.nutritionGrades.uppercased())
                        .font(.callout)
                        .foregroundStyle(Color.orange)
                }
                
                Spacer()
            }
        }
    }
}
