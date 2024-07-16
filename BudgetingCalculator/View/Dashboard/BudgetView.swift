//
//  ContentView.swift
//  TesBudgetView
//
//  Created by Kevin Fairuz on 10/07/24.
//

import SwiftUI
import SwiftData

struct BudgetView: View {
    @State var isCalculatorSheetPresented = false
    @ObservedObject var viewModel: BudgetViewModel

    @Environment(\.locale) var locale
    
    @State private var isUpdateBalanceSheetPresented = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Account Balance Section
                    AccountBalanceView(viewModel: viewModel)
                        .padding(.bottom, 4)
       
                    // Expense Categories View
                    ExpenseCategoriesView(viewModel: viewModel)
                            .padding(.horizontal)
                    
                    // Recent Expenses
                    RecentExpensesView(viewModel: viewModel)
                            
                    }
                    .padding(.bottom, 8)
                }
                .padding()
                .navigationTitle("SeniorBudget")
                .frame(maxHeight: .infinity)
                .frame(width: 425)
            }
        
    }
        
}

#Preview {
    TabBarView()
        .modelContainer(for: [Expense.self, BudgetCategory.self], inMemory: true)
}
