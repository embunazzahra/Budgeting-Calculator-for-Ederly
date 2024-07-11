//
//  Income.swift
//  BudgetingCalculator
//
//  Created by Kevin Fairuz on 11/07/24.
//

import SwiftData
import Foundation

@Model 
final class Income {
    @Attribute(.unique) var id: UUID = UUID() // Unique identifier
    var amount: Double
    var date: Date
    var source: String = "Dana Pensiun" // Default source

    init(amount: Double, date: Date = Date(), source: String = "Dana Pensiun") {
        self.amount = amount
        self.date = date
        self.source = source
    }
}

