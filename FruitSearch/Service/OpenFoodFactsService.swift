//
//  OpenFoodFactsService.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 16.07.24.
//

import Foundation

struct OpenFoodFactsService {
    func fetchList(searchBy fruitName: String) async throws -> FoodProductList {
        let fields: Array<String> = [
            "code",
            "nutrition_grades",
            "product_name"
        ]
        
        let sortBy: Array<String> = [
            "scans_n"
        ]
        
        guard let url = Self.OpenAPI.search(categoriesTagsValue: fruitName, fields: fields, sortyBy: sortBy) else {
            throw OpenFoodFactsError.invalidURL
        }
        
        let dataAndResponse: (data: Data, response: HTTPURLResponse)? = try? await URLSession.shared.data(from: url) as? (Data, HTTPURLResponse)
        
        guard let dataAndResponse, dataAndResponse.response.statusCode == 200 else {
            throw OpenFoodFactsError.invalidRespsone
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try decoder.decode(FoodProductList.self, from: dataAndResponse.data)
        } catch {
            throw OpenFoodFactsError.invlaidData
        }
    }
}

extension OpenFoodFactsService {
    struct OpenAPI {
        static func search(categoriesTagsValue: String, fields: Array<String> = [], sortyBy: Array<String> = []) -> URL? {
            var fieldsURLPart = ""
            if fields.isEmpty == false{
                fieldsURLPart = "&fields="
                var index = 0
                for field in fields {
                    if index == 0 {
                        fieldsURLPart += field
                    }else {
                        fieldsURLPart += ",\(field)"
                    }
                    index += 1
                }
            }
            
            var sortByURLPart = ""
            if sortyBy.isEmpty == false {
                sortByURLPart = "&sort_by="
                var index = 0
                for field in fields {
                    if index == 0 {
                        sortByURLPart += field
                    }else {
                        sortByURLPart += ",\(field)"
                    }
                    index += 1
                }
            }
            
            let url = URL(
                string:
                    "https://world.openfoodfacts.net/api/v2/search?categories_tags=\(categoriesTagsValue)\(fieldsURLPart)\(sortByURLPart)"
            )
            return url
        }
    }
}






