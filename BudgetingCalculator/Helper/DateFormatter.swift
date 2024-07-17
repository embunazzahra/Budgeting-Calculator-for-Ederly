//
//  DateFormatter.swift
//  BudgetingCalculator
//
//  Created by Dhau Embun Azzahra on 15/07/24.
//

import Foundation

extension Date {
    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy"
        return formatter.string(from: self)
    }
    
    func format(_ format: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}
