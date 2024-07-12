//
//  ExpenseViewMode.swift
//  BudgetingCalculator
//
//  Created by Kevin Fairuz on 12/07/24.
//

import Foundation
import SwiftUI
import SwiftData


class ExpenseViewModel: ObservableObject {
    private let dataSource: SwiftDataService
    @Published var expenses: [Expense] = []
    
    init(dataSource: SwiftDataService) {
        self.dataSource = dataSource
        
        // Add dummy expenses to the SwiftData to see if fetching data is works
    }
    
    
    func addExpense(category: String, amount: Double) {
        let expenseCategory = ExpenseCategory(rawValue: category) ?? .other
        let newExpense = Expense(category: expenseCategory, amount: amount)
    }

    func deleteExpense(at offsets: IndexSet) {
//        for index in offsets {
///           modelContext.delete(expenses[index])
//        }
    }
    
    func expensesForCategoryAndDate(category: ExpenseCategory, date: Date) -> [Expense] {
            return expenses.filter {
                $0.category == category && Calendar.current.isDate($0.date, inSameDayAs: date)
            }
        }
    
}


