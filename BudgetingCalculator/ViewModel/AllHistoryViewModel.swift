//
//  AllHistoryViewModel.swift
//  BudgetingCalculator
//
//  Created by Dhau Embun Azzahra on 15/07/24.
//

import Foundation

import SwiftUI
import SwiftData

class AllHistoryViewModel: ObservableObject {
    private let dataSource: SwiftDataService
    @Published var expenses: [Expense] = []
    
    init(dataSource: SwiftDataService){
        self.dataSource = dataSource
        initializeExpenses()
    }
    
    private func initializeExpenses(){
        if dataSource.fetchExpenses().isEmpty{
            let dummyExpenses = [
                Expense(category: .household, amount: 300000.0),
                Expense(category: .household, amount: 100000.0),
                Expense(category: .health, amount:500000.0),
                Expense(category: .other, amount:200000.0),
                Expense(category: .savings, amount:20000.0),
            ]
            
            for expense in dummyExpenses {
                dataSource.addExpense(expense)
            }
        }
        self.expenses = dataSource.fetchExpenses()
    }
}
