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
    @ObservedObject var viewModel: BudgetViewModel = BudgetViewModel(dataSource: .shared)

    @Environment(\.locale) var locale
    
    @State private var isUpdateBalanceSheetPresented = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Account Balance Section
                    AccountBalanceView(viewModel: viewModel)
                        .padding(.bottom, 8)
       
                    // Expense Categories View
                    ExpenseCategoriesView(viewModel: viewModel)
                        .padding(.bottom, 8)
                            .padding(.horizontal)
                    
                    // Recent Expenses
                    RecentExpensesView(viewModel: viewModel)
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                            
                    }
                    .padding(.bottom, 8)

                }
            .padding(.horizontal)
            .id(viewModel.triggerRefresh)
            .navigationTitle("SeniorBudget")
            .frame(maxHeight: .infinity)
            .frame(width: 425)
            .onAppear(){
                print(viewModel.triggerRefresh)
            }
            }
        
    }
        
}

#Preview {
    TabBarView()
        .modelContainer(for: [Expense.self, BudgetCategory.self], inMemory: true)
}
