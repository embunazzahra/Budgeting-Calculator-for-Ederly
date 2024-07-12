//
//  BudgetingCalculatorApp.swift
//  BudgetingCalculator
//
//  Created by Dhau Embun Azzahra on 10/07/24.
//

import SwiftUI
@main
struct BudgetingCalculatorApp: App {
    var body: some Scene {
        WindowGroup {
                    TabBarView()
                        .modelContainer(for: [Expense.self, BudgetCategory.self], inMemory: false)
                }
    }
}
