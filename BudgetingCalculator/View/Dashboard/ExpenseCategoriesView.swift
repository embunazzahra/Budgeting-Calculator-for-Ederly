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
        NavigationView{
            VStack(alignment: .leading, spacing: 20) {
                Text("Remaining Budget")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(ExpenseCategory.allCases) { category in
                        NavigationLink(destination: CalcView( category: category)){
                            ExpenseCategoryView(category: category, viewModel: viewModel)
                        }
                    }.padding(.all,10)
                    
                    
                }
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                
                
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 25)
            .background(Color(.whiteBlue)) // Background color for the Expenses section
            .cornerRadius(10)
            
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    BudgetView()
}
