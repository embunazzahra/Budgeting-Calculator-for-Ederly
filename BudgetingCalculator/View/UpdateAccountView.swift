//
//  UpdateAccountView.swift
//  Calculator
//
//  Created by Kevin Fairuz on 10/07/24.
//

import SwiftUI

import SwiftUI

struct UpdateAccountView: View {
    @ObservedObject var viewModel: BudgetViewModel
    @Environment(\.dismiss) var dismiss // Untuk menutup sheet

    @State private var newBalance: String = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("New Account Balance", text: $newBalance)
                    .keyboardType(.decimalPad)
                    .padding()

                Button("Update") {
                    if let newBalanceValue = Double(newBalance) {
                        viewModel.accountBalance = Int(newBalanceValue)
                        dismiss() // Tutup sheet setelah update
                    }
                }
                .padding()
            }
            .navigationTitle("Update Account Balance")
        }
    }
}


