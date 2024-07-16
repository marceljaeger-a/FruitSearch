//
//  FoodList.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 16.07.24.
//

import Foundation

struct FoodProductList: Codable {
    var count: Int
    var page: Int
    var pageCount: Int
    var pageSize: Int
    var products: Array<FoodProduct>
}
