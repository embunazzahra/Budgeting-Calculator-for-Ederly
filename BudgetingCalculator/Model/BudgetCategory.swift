//
//  BudgetCategory.swift
//  BudgetingCalculator
//
//  Created by Kevin Fairuz on 11/07/24.
//

import SwiftUI
import SwiftData
import Foundation

@Model
final class BudgetCategory {
    var id: UUID
    var category: ExpenseCategory
    var allocatedAmount: Double

    init(id: UUID = UUID(), category: ExpenseCategory, allocatedAmount: Double) {
        self.id = id
        self.category = category
        self.allocatedAmount = allocatedAmount
    }
}
