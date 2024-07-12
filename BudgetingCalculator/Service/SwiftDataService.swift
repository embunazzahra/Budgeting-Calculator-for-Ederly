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
        self.modelContainer = try! ModelContainer(for: Expense.self, Balance.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.modelContext = modelContainer.mainContext
    }
    
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
    
    func fetchBalance() -> Balance? {
        do {
            return try modelContext.fetch(FetchDescriptor<Balance>()).first
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
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
}
