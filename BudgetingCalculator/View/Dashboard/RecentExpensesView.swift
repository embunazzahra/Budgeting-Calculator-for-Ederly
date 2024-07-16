//
//  RecentExpensesView.swift
//  BudgetingCalculator
//
//  Created by Michael Varian Kostaman on 15/07/24.
//

import SwiftUI

struct RecentExpensesView: View {
    @ObservedObject var viewModel: BudgetViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Recent Expenses")
                    .font(.system(size: 22))
                    .fontWeight(.bold)

                Spacer()
                // Navigation ke All Record
                NavigationLink(destination: AccountBalanceView(viewModel: viewModel)) {
                    Text("View All")
                        .foregroundColor(.blue)
                        .padding(.top, 2)
                }
            }
            .padding(.bottom, 10)

            
            // List
            VStack(alignment: .leading, spacing: 10) {
                ForEach(viewModel.expenses.sorted(by: { $0.date > $1.date }).prefix(3), id: \.self) { expense in
                    ExpenseRowView(expense: expense)
                    Divider()
                }
            }
            .background(Color(.white)) // Background color for the list
            .cornerRadius(10)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background(Color(.whiteBlue)) // Background color for the Expenses section
        .cornerRadius(10)
        .frame(width: .infinity)
        
        
    }
}

struct ExpenseRowView: View {
    let expense: Expense
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(formattedDate)
                .fontWeight(.semibold)
                .padding(.bottom, 10)
            
            HStack {
                // Icon
                ZStack {
                    Circle()
                        .foregroundColor(expense.category.color)
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: expense.category.icon)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
                
                
                // Name
                Text(expense.category.localizedString)
                
                Spacer()
                
                Text("-IDR \(expense.amount, specifier: "%.f")")
                    .foregroundColor(Color.red)
                    .fontWeight(.semibold)
            }
        }
        //        .padding(.vertical, 5)
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM"
        return formatter.string(from: expense.date)
    }
}

#Preview {
    RecentExpensesView(viewModel: BudgetViewModel(dataSource: .shared))
}
