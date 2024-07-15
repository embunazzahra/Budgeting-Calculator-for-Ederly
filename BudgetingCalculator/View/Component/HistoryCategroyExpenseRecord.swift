//
//  HistoryCategroyExpenseRecord.swift
//  BudgetingCalculator
//
//  Created by Michael Varian Kostaman on 15/07/24.
//

import SwiftUI

struct HistoryCategroyExpenseRecord: View {
    var expense: Expense
    var date: Date
    var amount: Double
    
    // Pindahin ke ViewModel
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM"
        return formatter.string(from: date)
    }
    
    var body: some View {
        VStack(spacing: 0) { // Using VStack to manage the border line at the bottom
            HStack {
                Text(formattedDate)
                Spacer()
                Text("-\(amount, specifier: "%.2f")")
            }
            .padding()
            .background(expense.category.colorBack)
            .frame(width: 320, height: 52)
            .cornerRadius(10)

            Rectangle() // Adding the bottom border line
                .fill(Color(.bordercolor)) // Change the color of the border line as needed
                .frame(height: 1) // Adjust the height of the border line
        }
        .frame(width: 305)
    }
}

#Preview {
    HistoryCategroyExpenseRecord(expense: Expense(category: .health, amount: 25000), date: Date(), amount: 25000)
}

