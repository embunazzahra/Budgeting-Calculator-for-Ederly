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
    @StateObject var viewModel: BudgetViewModel = BudgetViewModel(dataSource: .shared)
    @Environment(\.locale) var locale
    
    @State private var isUpdateBalanceSheetPresented = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    // Account Balance Section
                    AccountBalanceView(viewModel: viewModel)
                        .padding(.horizontal)
                    
                    // Expenses Section
                    NavigationLink(destination: CalcView()){
                        ExpenseCategoriesView(viewModel: viewModel)
                            .padding(.horizontal)
                            .padding(.bottom) // Add padding to the bottom of the section
                        
                    }.buttonStyle(.plain)
                    
                    Spacer() // Push the content to the top
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
