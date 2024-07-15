//
//  RemainingBudgetCategoryCard.swift
//  BudgetingCalculator
//
//  Created by Michael Varian Kostaman on 14/07/24.
//

import SwiftUI

struct RemainingBudgetCategoryCard: View {
    let category: ExpenseCategory
    @ObservedObject var viewModel: BudgetViewModel
    @State private var isUpdateBalanceSheetPresented = false // State untuk sheet Edit
    
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            Text("Remaining Budget")
                .font(.system(size: 20))
                .fontWeight(.semibold)
            
            Text("IDR \(viewModel.remainingBudgetForCategory(category), specifier: "%.2f")")
                .font(.system(size: 34))
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            // Change with ViewModel
            Text("Spent: \(viewModel.totalExpenseForCategory(category), specifier: "%.2f")")
                .foregroundColor(.red)
                .padding(.vertical, 4)
                .padding(.horizontal, 30)
                .background(Color.black)
                .cornerRadius(13)
                .font(.system(size: 17))
                .fontWeight(.semibold)
        }
        .frame(width: 320, height: 129)
        .padding([.top, .bottom], 10)
        .padding([.leading, .trailing], 20)
        .background(Color(category.color))
        .cornerRadius(15)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    RemainingBudgetCategoryCard(category: .household, viewModel: BudgetViewModel(dataSource: .shared))
}
