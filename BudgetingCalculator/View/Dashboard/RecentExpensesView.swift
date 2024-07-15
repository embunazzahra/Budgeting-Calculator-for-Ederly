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
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Recent Expenses")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                
                
                // List
                
            }
            .padding(.horizontal, 10)
            .padding(.leading, 5)
            .padding(.vertical, 25)
            .background(Color(.whiteBlue)) // Background color for the Expenses section
            .cornerRadius(10)
            
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    RecentExpensesView(viewModel: BudgetViewModel(dataSource: .shared))
}
