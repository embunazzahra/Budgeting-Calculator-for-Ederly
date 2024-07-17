//
//  EditBalance.swift
//  BudgetingCalculator
//
//  Created by Michael Varian Kostaman on 11/07/24.
//

import SwiftUI

struct EditBalanceView: View {
    @EnvironmentObject var viewModel: BudgetViewModel
    @State private var inputValue: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    private let numberSeperator = NumberSeperator()
    
    var body: some View {
        VStack {
            HStack {
                Text("Edit Balance")
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .padding(.leading, 20)
                    .padding(.top, 20)
                Spacer()
            }
            
            TextField("IDR XXX.XXX", text: $inputValue)

                .keyboardType(.numberPad)
                .padding()
                .padding(.leading, 10)
                .background(Color.gray.opacity(0.3).cornerRadius(10))
            
                
                
                
                .frame(width: 350)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 8)
//                        .stroke(Color.gray, lineWidth: 1)
//                        .padding([.horizontal])
//                )
                .onChange(of: inputValue) { newValue in
                    inputValue = numberSeperator.formatNumber(inputValue)
                }

            
            Spacer()
            
            Button(action: {
                if let newBalance = Int(numberSeperator.revertFormat(inputValue)) {
                    viewModel.updateBalance(accountBalance: newBalance)
                    print("Updated balance to \(newBalance)")
                    print("\(viewModel.accountBalance)")
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                } else {
                    print("Invalid Input")
                }
             }) {
                 Text("Confirm Update")
                     .padding()
                     .foregroundColor(.white)
                     .background(Color.blue)
                     .cornerRadius(8)
             }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EditBalanceView()
}
