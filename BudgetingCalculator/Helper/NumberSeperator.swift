//
//  NumberSeperator.swift
//  BudgetingCalculator
//
//  Created by Michael Varian Kostaman on 12/07/24.
//

import Foundation

class NumberSeperator {
    public func formatNumber(_ number: String) -> String {
        let cleanedNumber = number.replacingOccurrences(of: ".", with: "")
        guard let numberValue = Int(cleanedNumber) else {
            return number
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."
        numberFormatter.locale = Locale(identifier: "id_ID")
        
        return numberFormatter.string(from: NSNumber(value: numberValue)) ?? number
    }
}
