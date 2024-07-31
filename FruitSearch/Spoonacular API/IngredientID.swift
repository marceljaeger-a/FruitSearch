//
//  IngredientId.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 26.07.24.
//

import Foundation

struct IngredientID: Codable {
    var name: String
    var value: Int
    
    static func get(of name: String) -> Self? {
        do {
            let savedIdentifiers = try Self.loadData()
            return savedIdentifiers.first(where: { $0.name.lowercased() == name.lowercased() })
        } catch {
            print(error)
            return nil
        }
    }
}

extension IngredientID {
    enum IngredientIDError: Error {
        case invalidFileURL
        case invalidFileContent
        case invalidData
    }
    
    private static func loadData() throws -> Array<Self> {
        let url = Bundle.main.url(forResource: "IngredientIDs", withExtension: "json")
        guard let url else { throw IngredientIDError.invalidFileURL }
        
        let content = FileManager.default.contents(atPath: url.path())
        guard let content else { throw IngredientIDError.invalidFileContent }
        
        let decoder = JSONDecoder()
        let ids = try? decoder.decode(Array<Self>.self, from: content)
        guard let ids else { throw IngredientIDError.invalidData }
        
        return ids
    }
    
//    private static func saveData(_ data: Array<Self>) throws {
//        
//    }
}



