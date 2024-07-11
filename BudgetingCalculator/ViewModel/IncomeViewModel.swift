//
//  IncomeViewModel.swift
//  BudgetingCalculator
//
//  Created by Kevin Fairuz on 11/07/24.
//

import SwiftUI
import SwiftData

class IncomeViewModel: ObservableObject {
    @Environment(\.modelContext) var modelContext
    @State private var accountBalance: Double = 0
    @Published var incomes: [Income] = []
   
    
    init() {
        fetchIncomes()
    }
    
    func fetchIncomes() {
           let descriptor = FetchDescriptor<Income>()
           do {
               incomes = try modelContext.fetch(descriptor)
           } catch {
               print("Error fetching incomes: \(error)")
           }
       }

       func addIncome(amount: Double, source: String) {
           let newIncome = Income(amount: amount, source: source)
           modelContext.insert(newIncome)
           accountBalance += amount // Update account balance
           fetchIncomes()
       }

       func deleteIncome(at offsets: IndexSet) {
           for index in offsets {
               let income = incomes[index]
               accountBalance -= income.amount // Update account balance
               modelContext.delete(income)
           }
           fetchIncomes()
       }
}
