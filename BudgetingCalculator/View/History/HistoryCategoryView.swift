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
            Text("History for \(category.rawValue)")
                .font(.system(size: 20))
                .fontWeight(.semibold)
            Divider()
            
            // Remaining Budget Category Card
            RemainingBudgetCategoryCard(category: category, viewModel: BudgetViewModel(dataSource: .shared))
            
            ScrollView {
                VStack {
                    ForEach(viewModel.expensesGroupedByDate(for: category).sorted(by: { $0.key > $1.key }), id: \.key) { date, expenses in
                        VStack (spacing: 0) {
                            ForEach(expenses) { expense in
                                HistoryCategroyExpenseRecord(expense: expense, date: expense.date, amount: expense.amount)
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

struct MockData {
    static let sampleCategory: ExpenseCategory = .health
    static let sampleViewModel: BudgetViewModel = {
        let viewModel = BudgetViewModel(dataSource: .shared)
        // Add any additional setup if needed
        return viewModel
    }()
}

#Preview {
    HistoryCategoryView(category: MockData.sampleCategory, viewModel: MockData.sampleViewModel)
}
