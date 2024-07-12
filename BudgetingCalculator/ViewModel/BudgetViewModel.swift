//
//  BudgetViewModel.swift
//  Calculator
//
//  Created by Kevin Fairuz on 09/07/24.
//

import SwiftUI
import SwiftData

class BudgetViewModel: ObservableObject {
    private let dataSource: SwiftDataService
    @Published var expenses: [Expense] = []
    @Published var budgetCategories: [BudgetCategory] = []
    @Published var isDarkMode: Bool = false
    @Published var currentNumber: String = "0"
    @Published var isCalculatorSheetPresented = false
    @Published var accountBalance = 10000000 // Initial Account Balance
    @Published var selectedCategory: ExpenseCategory?
    
    init(dataSource: SwiftDataService) {
        self.dataSource = dataSource
        
        // Add dummy expenses to the SwiftData to see if fetching data is works
        if let balance = dataSource.fetchBalance() {
            self.accountBalance = balance.accountBalance
        } else {
            // If balance is not found, you might want to handle this case
            print("Balance not found")
        }
        
        initializeDummyBudgetCategories()
    }
    
    private func initializeDummyBudgetCategories() {
        // Check if there are existing categories to avoid duplication
        if budgetCategories.isEmpty {
            let dummyCategories = [
                BudgetCategory(category: .household, allocatedAmount: 500.0),
                BudgetCategory(category: .health, allocatedAmount: 200.0),
                BudgetCategory(category: .other, allocatedAmount: 150.0),
                BudgetCategory(category: .savings, allocatedAmount: 100.0)
            ]
            self.budgetCategories = dummyCategories
        }
    }
    
    func addExpense(category: String, amount: Double) {
        let expenseCategory = ExpenseCategory(rawValue: category) ?? .other
        let newExpense = Expense(category: expenseCategory, amount: amount)
    }

    func updateBalance(accountBalance: Int){
        self.accountBalance = accountBalance
        dataSource.updateAccountBalance(newBalance: accountBalance)
    }
    
    func deleteExpense(at offsets: IndexSet) {
//        for index in offsets {
///           modelContext.delete(expenses[index])
//        }
    }

    var totalExpenses: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }

    var remainingBalance: Double {
        max(0, Double(accountBalance) - totalExpenses)
    }

//    func angleForCategory(_ category: String) -> Double {
//        let filteredExpenses = expenses.filter { $0.category == category }
//        let categoryTotal = filteredExpenses.reduce(0) { $0 + $1.amount }
//        let proportion = totalExpenses > 0 ? categoryTotal / totalExpenses : 0
//        return proportion * 360
//    }

    func saveBudgetCategories() {
        do {
//            try modelContext.save()
        } catch {
            print("Error saving budget categories: \(error)")
        }
    }

    func remainingBudgetForCategory(_ category: ExpenseCategory) -> Double {
        let categoryBudget = budgetCategories.first(where: { $0.category == category })?.allocatedAmount ?? 0
        let spent = expenses.filter { $0.category == category }.reduce(0) { $0 + $1.amount }
        return max(0, categoryBudget - spent)
    }
    
}