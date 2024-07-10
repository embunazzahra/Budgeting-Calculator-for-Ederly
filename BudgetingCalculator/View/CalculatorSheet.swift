//
//  CalculatorSheet.swift
//  Calculator
//
//  Created by Kevin Fairuz on 10/07/24.
//

import SwiftUI

import SwiftUI

struct CalculatorSheet: View {
    @ObservedObject var viewModel: BudgetViewModel
    @Environment(\.dismiss) var dismiss
    @State private var selectedCategory: ExpenseCategory = .household // Default category
    
    @State private var currentNumber: Double = 0
    @State private var storedNumber: Double? = nil
    @State private var currentOperation: Operation? = nil
    
    
    enum Operation {
        case add, subtract, multiply, divide
    }


    let buttonSize: CGFloat = 60 // Smaller button size
    let fontSize: CGFloat = 30   // Smaller font size

    var body: some View {
        VStack(spacing: 10) {
            // Display Area
            TextField("0", text: $viewModel.currentNumber)
                .font(.system(size: fontSize * 1.5, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                .disabled(true) // Make it non-editable
            
            Picker("Category", selection: $selectedCategory) {
                ForEach(ExpenseCategory.allCases, id: \.self) { category in
                    Text(category.rawValue).tag(category.rawValue)
                }
            }.pickerStyle(.segmented)
                .padding(.horizontal)
            
            // Number Pad
            VStack(spacing: 10) {
                ForEach(0..<3) { row in
                    HStack(spacing: 10) {
                            ForEach(0..<4) { col in
                            let number = row * 3 + col
                                Button(action: {
                                    digitTapped(number)
                                }) {
                                    Text("\(number)")
                                        .frame(width: buttonSize, height: buttonSize)
                                }
                                .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }

            // Operations
            HStack(spacing: 10) {
                ForEach([Operation.add, Operation.subtract, Operation.multiply, Operation.divide], id: \.self) { operation in
                    Button(action: {
                        handleOperation(operation) // Call your handleOperation function
                    }) {
                        Text(operationSymbol(operation))
                            .font(.system(size: fontSize, weight: .bold))
                            .frame(width: buttonSize, height: buttonSize)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(buttonSize / 2)
                    }
                }
            }

            // Other Buttons
            HStack(spacing: 10) {
                Button("C") { clear() } // Call your clear function
                Button("=") {
                    calculate()  // Call your calculate function
                    viewModel.addExpense(category: selectedCategory.rawValue, amount: Double(viewModel.currentNumber) ?? 0) // Add expense to the ViewModel
                    dismiss() // Dismiss the sheet
                }
                Button(".") { addDecimal() } // Call your addDecimal function
            }
            .buttonStyle(CalculatorButtonStyle(size: buttonSize, fontSize: fontSize))

            // Category Picker
            Picker("Category", selection: $selectedCategory) {
                ForEach(ExpenseCategory.allCases, id: \.self) { category in
                    Text(category.rawValue).tag(category.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding()
        }
        .padding()
    }

    func digitTapped(_ number: Int) {
        if viewModel.currentNumber == "0" {
            viewModel.currentNumber = "\(number)"
        } else {
            viewModel.currentNumber += "\(number)"
        }
    }

    func handleOperation(_ operation: Operation) {
        if let current = Double(viewModel.currentNumber) {
            storedNumber = current
            currentNumber = 0
            currentOperation = operation
        }
    }
    
    func operationSymbol(_ operation: Operation) -> String {
        switch operation {
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        }
    }

    func clear() {
        currentNumber = 0
        storedNumber = 0
        currentOperation = nil
    }

    func calculate() {
        if let current = Double(viewModel.currentNumber),
           let stored = storedNumber,
           let operation = currentOperation {
            switch operation {
            case .add: currentNumber = (stored + current)
            case .subtract: currentNumber = (stored - current)
            case .multiply: currentNumber = (stored * current)
            case .divide:
                if current != 0 {
                    currentNumber = (stored / current)
                } else {
 
                }
            }
            currentOperation = nil // Reset the operation after calculation
        }
    }

    func addDecimal() {
        if let current = Double(viewModel.currentNumber), // Convert to Double for calculation
           !viewModel.currentNumber.contains(".") {
            viewModel.currentNumber = String(format: "%.1f", current) // Append decimal point
        }
    }

    
    // Custom button style for clearer visuals
    struct CalculatorButtonStyle: ButtonStyle {
        let size: CGFloat
        let fontSize: CGFloat

        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.system(size: fontSize, weight: .bold))
                .frame(width: size, height: size)
                .background(configuration.isPressed ? Color.gray : Color.white) // Visual feedback on press
                .foregroundColor(.black)
                .cornerRadius(size / 2)
        }
    }
}

// ... (ExpenseCategory enum, BudgetViewModel, BudgetView remain the same)


