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
                .font(.system(size: 17))
            Text("IDR \(viewModel.accountBalance)")
                .font(.system(size: 28))
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            Button(action: {
                isUpdateBalanceSheetPresented = true
            }) {
                Text("Edit Balance")
                    .padding([.top, .bottom], 12)
                    .padding([.leading, .trailing], 104)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                    )
                    .cornerRadius(5)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
            }
            .sheet(isPresented: $isUpdateBalanceSheetPresented) {
                EditBalanceView()
                    .environmentObject(viewModel)
                    .presentationDetents([.medium, .medium])
            }
        }
        .padding([.top, .bottom], 30)
//        .padding([.leading, .trailing], 20)
        .frame(maxWidth: .infinity)
        .background(Color(.whiteBlue))
        .cornerRadius(15)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    AccountBalanceView(viewModel: BudgetViewModel(dataSource: .shared))
}
