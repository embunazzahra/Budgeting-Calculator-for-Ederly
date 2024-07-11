//
//  AccountBalanceView.swift
//  BudgetingCalculator
//
//  Created by Michael Varian Kostaman on 11/07/24.
//

import SwiftUI

struct AccountBalanceView: View {
    @ObservedObject var viewModel: BudgetViewModel
    @State private var isUpdateBalanceSheetPresented = false // State untuk sheet Edit

    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("Account Balance")
                .font(.headline)
                .foregroundColor(.gray)
            Text("IDR \(viewModel.accountBalance, specifier: "%.2f")")
                .font(.largeTitle)
                .fontWeight(.bold)
            NavigationLink(destination: UpdateAccountView(viewModel: viewModel)) {
                Text("Edit Balance")
                    .frame(maxWidth: .infinity) // Make button full width
                    .padding()
                    .background(.blue) // Set background color for the button
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 5)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray4))
        .cornerRadius(10)
    }
}
