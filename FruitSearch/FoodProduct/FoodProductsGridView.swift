//
//  FoodProductsGridView.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 24.07.24.
//

import Foundation
import SwiftUI

struct FoodProductsGridView: View {
    
    //MARK: - Dependencies
    
    let products: Array<FoodProduct>
    
    //MARK: - Methods
    
    
    
    //MARK: - Body
    
    var body: some View {
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
}
