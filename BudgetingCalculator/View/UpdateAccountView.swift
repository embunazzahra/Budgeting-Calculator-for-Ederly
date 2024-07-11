//
//  UpdateAccountView.swift
//  Calculator
//
//  Created by Kevin Fairuz on 10/07/24.
//

import SwiftUI

struct UpdateAccountView: View {
    @ObservedObject var viewModel: BudgetViewModel = BudgetViewModel(dataSource: .shared)
    @Environment(\.dismiss) var dismiss

    @State private var amount: String = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)

//                Button("Add Income") {
//                    if let amountValue = Double(amount) {
//                        viewModel.addIncome(amount: amountValue, source: "Dana Pensiun") // Panggil addIncome pada viewModel
//                        dismiss()
//                    }
                }
            }
            .navigationTitle("Update Account Balance")
        
    }
}




