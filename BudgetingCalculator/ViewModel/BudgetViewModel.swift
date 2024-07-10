//
//  BudgetViewModel.swift
//  Calculator
//
//  Created by Kevin Fairuz on 09/07/24.
//

import SwiftUI
import SwiftData

class BudgetViewModel: ObservableObject {
    @Environment(\.modelContext) var modelContext
    @Published var expenses: [Expense] = []
    @Published var budgetCategories: [BudgetCategory] = []
    @Published var isDarkMode: Bool = false
    @Published var currentNumber: String = "0"
    @Published var isCalculatorSheetPresented = false
    @Published var accountBalance = 10000000 // Initial Account Balance
    @Published var selectedCategory: ExpenseCategory?
    
    init() {
        fetchExpenses()
        fetchBudgetCategories()
    }
    
    func fetchExpenses() {
        let descriptor = FetchDescriptor<Expense>(
            predicate: nil, // Fetch all expenses
            sortBy: [SortDescriptor(\Expense.date, order: .reverse)] // Sort by date descending
        )
        do {
            expenses = try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching expenses: \(error)")
        }
    }
    
    func addExpense(category: String, amount: Double) {
        let expenseCategory = ExpenseCategory(rawValue: category) ?? .other
        let newExpense = Expense(category: expenseCategory, amount: amount)
        modelContext.insert(newExpense)
        fetchExpenses()
    }

    func deleteExpense(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(expenses[index])
        }
        fetchExpenses()
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
    
    func fetchBudgetCategories() {
        let descriptor = FetchDescriptor<BudgetCategory>()
        do {
            budgetCategories = try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching budget categories: \(error)")
        }
    }

    func saveBudgetCategories() {
        do {
            try modelContext.save()
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
