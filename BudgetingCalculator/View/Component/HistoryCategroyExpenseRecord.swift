//
//  HistoryCategroyExpenseRecord.swift
//  BudgetingCalculator
//
//  Created by Michael Varian Kostaman on 15/07/24.
//

import SwiftUI

struct HistoryCategroyExpenseRecord: View {
    var expense: Expense
    @ObservedObject var viewModel: BudgetViewModel
    
    // Pindahin ke ViewModel
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM"
        return formatter.string(from: expense.date)
    }
    
    var body: some View {
        VStack(spacing: 0) { // Using VStack to manage the border line at the bottom
            HStack {
                Text(formattedDate)
                    .foregroundColor(.font)
                    .fontWeight(.light)
                    .bold()
                Spacer()
                Text("-\(expense.amount, specifier: "%.2f")")
                    .foregroundColor(Color.red)
            }
            .padding()
            .background(expense.category.colorHistory)
            .frame(width: 320, height: 52)
            .cornerRadius(10)

//            Rectangle()
//                .fill(Color(.bordercolor))
//                .frame(height: 1)
        }
        .frame(width: 305)
    }
}

#Preview {
    HistoryCategroyExpenseRecord(expense: Expense(category: .household, amount: 25000, date: Date()), viewModel: BudgetViewModel(dataSource: .shared))
}

