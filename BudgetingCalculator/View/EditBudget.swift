//
//  EditBudget.swift
//  BudgetingCalculator
//
//  Created by Kevin Fairuz on 16/07/24.
//

import SwiftUI

struct EditBudget: View {
    @EnvironmentObject var viewModel: BudgetViewModel
    @State private var inputValue: String = ""
    @Environment(\.presentationMode) var presentationMode
    let category: ExpenseCategory

    
    private let numberSeperator = NumberSeperator()
    
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }()

    
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
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                        .padding([.horizontal])
                )
                .onChange(of: inputValue) { newValue in
                    inputValue = numberSeperator.formatNumber(inputValue)
                }

            
            Spacer()
            
            Button(action: {
                if let newBudget =   Int(numberSeperator.revertFormat(inputValue)) {
                    viewModel.updateBudgetCategory(category: category, newAmount: Double(newBudget))
                    print("Updated balance to \(newBudget)")
                    
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
        .onAppear {
            // Set initial input value from existing budget
            if let existingBudget = viewModel.budgetCategories.first(where: { $0.category == category }) {
                inputValue = numberFormatter.string(from: NSNumber(value: existingBudget.allocatedAmount)) ?? ""
            }
        }
    }
}


#Preview {
    EditBudget(category: .health)
        .environmentObject(BudgetViewModel(dataSource: .shared))}
