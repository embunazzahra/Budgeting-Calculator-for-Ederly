//
//  ContentView.swift
//  TesBudgetView
//
//  Created by Kevin Fairuz on 10/07/24.
//

import SwiftUI
import SwiftData

struct BudgetView: View {
    @StateObject var viewModel: BudgetViewModel = BudgetViewModel(dataSource: .shared)
    @Environment(\.locale) var locale
    @State private var isUpdateBalanceSheetPresented = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Account Balance Section
                    AccountBalanceView(viewModel: viewModel)
                        .padding(.bottom, 8)
                    
                    // Expenses Section
                    NavigationLink(destination: CalcView()){
                        ExpenseCategoriesView(viewModel: viewModel)
                            .padding(.horizontal)
                            .padding(.bottom, 8) // Add padding to the bottom of the section
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 8)
                }
                .padding()
                .navigationTitle("SeniorBudget")
                .frame(maxHeight: .infinity)
                .frame(width: 425)
            }
        }
        
    }
        
}

#Preview {
    TabBarView()
        .modelContainer(for: [Expense.self, BudgetCategory.self], inMemory: true)
}
