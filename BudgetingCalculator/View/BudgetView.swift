//
//  ContentView.swift
//  TesBudgetView
//
//  Created by Kevin Fairuz on 10/07/24.
//

import SwiftUI
import SwiftData

struct BudgetView: View {
    @StateObject var viewModel = BudgetViewModel()
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

struct AccountBalanceView: View {
    @ObservedObject var viewModel: BudgetViewModel
    @State private var isUpdateBalanceSheetPresented = false // State untuk sheet Edit

    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("Account Balance")
                .font(.headline)
                .foregroundColor(.gray)
            Text("IDR \(viewModel.accountBalance, specifier: "%.2f")")
                .font(.largeTitle)
                .fontWeight(.bold)
            NavigationLink(destination: UpdateAccountView(viewModel: viewModel)) {
                Text("Edit Balance")
                    .frame(maxWidth: .infinity) // Make button full width
                    .padding()
                    .background(.blue) // Set background color for the button
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 5)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray4))
        .cornerRadius(10)
    }
}


    struct ExpenseCategoriesView: View {
        @ObservedObject var viewModel: BudgetViewModel
        
        var body: some View {
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Remaining Budget")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 25) {
                    ForEach(ExpenseCategory.allCases) { category in
                        ExpenseCategoryView(category: category, viewModel: viewModel)
                            .onTapGesture {
                                viewModel.selectedCategory = category
                                viewModel.isCalculatorSheetPresented = true
                            }
                        
                    }
                }
                    .padding(.bottom, 30)
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .offset(x: 5.5)
                
            }
            
            .background(Color(.systemGray6)) // Background color for the Expenses section
            .cornerRadius(10)
            .padding(.bottom, 10) // Add padding to the bottom of the section
        }
        
    }


#Preview {
    TabBarView()
}
