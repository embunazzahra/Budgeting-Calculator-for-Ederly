//
//  NumberSeperator.swift
//  BudgetingCalculator
//
//  Created by Michael Varian Kostaman on 12/07/24.
//

import Foundation

class NumberSeperator {
    private let numberFormatter: NumberFormatter
    
    init() {
        self.numberFormatter = NumberFormatter()
        self.numberFormatter.numberStyle = .decimal
        self.numberFormatter.groupingSeparator = "."
        self.numberFormatter.locale = Locale(identifier: "id_ID")
    }
    
    public func formatNumber(_ number: String) -> String {
        let cleanedNumber = number.replacingOccurrences(of: ".", with: "")
        guard let numberValue = Int(cleanedNumber) else {
            return number
        }
        
        return numberFormatter.string(from: NSNumber(value: numberValue)) ?? number
    }
    
    public func revertFormat(_ formattedNumber: String) -> String {
        let cleanedNumber = formattedNumber.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "")
        return cleanedNumber
    }
}
