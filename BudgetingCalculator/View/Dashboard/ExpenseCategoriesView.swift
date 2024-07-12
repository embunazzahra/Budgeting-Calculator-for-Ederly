//
//  ExpenseCategoriesView.swift
//  BudgetingCalculator
//
//  Created by Michael Varian Kostaman on 11/07/24.
//

import SwiftUI

struct ExpenseCategoriesView: View {
    @ObservedObject var viewModel: BudgetViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Remaining Budget")
                .font(.system(size: 22))
                .fontWeight(.bold)
                .padding(.bottom, 22)
                
            
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
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color(.whiteBlue)) // Background color for the Expenses section
        .cornerRadius(10)

    }
}

#Preview {
    ExpenseCategoriesView(viewModel: BudgetViewModel(dataSource: .shared))
}
