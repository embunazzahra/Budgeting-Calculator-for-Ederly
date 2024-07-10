//
//  HistoryView.swift
//  Calculator
//
//  Created by Kevin Fairuz on 10/07/24.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @ObservedObject var viewModel: BudgetViewModel
    @Environment(\.locale) var locale

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.expenses) { expense in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(expense.date, style: .date) // Show date
                                .font(.caption)
                            Text(expense.category.rawValue) // Show category
                                .font(.headline)
                        }
                        Spacer()
                        Text(String(format: "%@%.2f", locale.currencySymbol ?? "Rp", expense.amount)) // Show amount
                            .font(.headline)
                    }
                }
                .onDelete(perform: viewModel.deleteExpense) // Allow deleting expenses
            }
            .navigationTitle(LocalizedStringKey("History"))
        }
    }
}

