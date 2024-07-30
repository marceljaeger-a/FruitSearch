//
//  String +ext.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 30.07.24.
//

import Foundation

extension String {
    func uppercasedFirst() -> String {
        var value = self
        
        guard value.count > 0 else { return self }
        let firstChar = value.removeFirst()
        var newString = ""
        newString.append(firstChar.uppercased())
        newString.append(value)
        return newString
    }
}
