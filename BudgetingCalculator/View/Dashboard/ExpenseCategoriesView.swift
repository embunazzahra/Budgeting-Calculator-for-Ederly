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

//#Preview {
//    ExpenseCategoriesView()
//}
