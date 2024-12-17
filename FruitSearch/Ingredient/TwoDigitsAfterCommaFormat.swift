//
//  TwoNumberAfterCommaFormat.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 28.07.24.
//

import Foundation
import RegexBuilder

struct TwoDigitsAfterCommaFormat: FormatStyle {
    func format(_ value: Double) -> String {
        var string = String(value)
        
        let pattern = Regex {
            OneOrMore(.digit)
            "."
            One(.digit)
            One(.digit)
            Capture {
                OneOrMore(.digit)
            }
        }
        
        if let match = string.firstMatch(of: pattern) {
            let (wholeMatch, component) = match.output
            guard let range = string.range(of: component) else { return string }
            string.removeSubrange(range)
        }
        
        return string
    }
    
    typealias FormatInput = Double
    
    typealias FormatOutput = String
}

extension Double {
    func nutrientFormatted() -> String {
        TwoDigitsAfterCommaFormat().format(self)
    }
}
