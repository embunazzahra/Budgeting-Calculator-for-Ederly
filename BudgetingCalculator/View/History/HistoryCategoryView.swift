//
//  HistoryCategoryView.swift
//  BudgetingCalculator
//
//  Created by Michael Varian Kostaman on 14/07/24.
//

import SwiftUI

struct HistoryCategoryView: View {
    let category: ExpenseCategory
    @ObservedObject var viewModel: BudgetViewModel
    
    var body: some View {
        VStack {
            // Header
            Text("History for \(category.localizedString)")
                .font(.system(size: 20))
                .fontWeight(.semibold)
            Divider()
            
            // Remaining Budget Category Card
            RemainingBudgetCategoryCard(category: category, viewModel: viewModel)
            
            ScrollView {
                VStack {
                    ForEach(viewModel.expensesGroupedByDate(for: category).sorted(by: { $0.key > $1.key }), id: \.key) { date, expenses in
                        VStack (spacing: 0) {
                            ForEach(expenses) { expense in
                                HistoryCategroyExpenseRecord(expense: expense, viewModel: viewModel)
                            }
                        }
                        .padding(.bottom, 8)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
            
            Spacer()
        }
        
    }
}

#Preview {
    HistoryCategoryView(category: .health, viewModel: BudgetViewModel(dataSource: .shared))
}
