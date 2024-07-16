//
//  SwiftDataService.swift
//  BudgetingCalculator
//
//  Created by Michael Varian Kostaman on 11/07/24.
//

import Foundation
import SwiftUI
import SwiftData

class SwiftDataService {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = SwiftDataService()
    
    @MainActor
    private init() {
        // Change isStoredInMemoryOnly to false if you would like to see the data persistance after kill/exit the app
        self.modelContainer = try! ModelContainer(for: Expense.self, Balance.self, BudgetCategory.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }
    
    // Expense
    func fetchExpenses() -> [Expense] {
        do {
            return try modelContext.fetch(FetchDescriptor<Expense>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addExpense(_ expense: Expense) {
        modelContext.insert(expense)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // Budget Category
    func fetchBudgetCategory() -> [BudgetCategory] {
        do {
            return try modelContext.fetch(FetchDescriptor<BudgetCategory>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // Balance
    func fetchBalance() -> Balance? {
        do {
            return try modelContext.fetch(FetchDescriptor<Balance>()).first
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // Update Balance
    func updateAccountBalance(newBalance: Int) {
        do {
            var balance: Balance
            
            if let existingBalance = fetchBalance() {
                balance = existingBalance
            } else {
                balance = Balance(id: UUID(), accountBalance: newBalance)
                modelContext.insert(balance)
            }
            balance.accountBalance = newBalance
            try modelContext.save()
        } catch {
            fatalError("Error updating account balance: \(error.localizedDescription)")
        }
    }
    
    func addBudgetCategory(_ budgetCategory: BudgetCategory) {
        modelContext.insert(budgetCategory)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func updateBudgetCategory(category: ExpenseCategory, newAllocatedAmount: Double) {
        do {
            var arrayBudgetCategories = fetchBudgetCategory()

            // Search for existing budget category in your data structure (e.g., an array or dictionary)
            if let index = arrayBudgetCategories.firstIndex(where: { $0.category == category }) {
                // Update existing budget category
                var existingCategory = arrayBudgetCategories[index]
                existingCategory.allocatedAmount = newAllocatedAmount

                // Remove existing budget category from array
                arrayBudgetCategories.remove(at: index)

                // Delete the existing category from CoreData context
                modelContext.delete(existingCategory)
                let budgetCategory = BudgetCategory(id: UUID(), category: category, allocatedAmount: newAllocatedAmount)
                arrayBudgetCategories.append(budgetCategory)
            } else {
                // Create new budget category if it doesn't exist

            }
            
            // Insert or update each budget category in context
            for budgetCategory in arrayBudgetCategories {
                modelContext.insert(budgetCategory)
            }
            
            // Save changes to the context
            try modelContext.save()
            
            // Update or reassign the array of budget categories in your data source
            
        } catch {
            fatalError("Error updating budget category: \(error.localizedDescription)")
        }
    }
}
