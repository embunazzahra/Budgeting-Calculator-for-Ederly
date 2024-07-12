//
//  AddExpenseViewModel.swift
//  BudgetingCalculator
//
//  Created by Dhau Embun Azzahra on 12/07/24.
//

import SwiftUI
import SwiftData

class AddExpenseViewModel: ObservableObject {
    @Published var value = "0"
    @Published var runningNumber = 0
    @Published var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .one, .four, .seven, .zero],
        [.divide, .two, .five, .eight, .doubleZero],
        [.multiply, .three, .six, .nine, .decimal],
        [.del, .subtract, .add, .equal],
    ]
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    
    
    func getTextOrImage(for value: CalcButton) -> AnyView {
        switch value{
        case .del, .divide, .multiply, .subtract, .add, .equal:
            return AnyView(Image(systemName: value.rawValue))
        default:
            return AnyView(Text(value.rawValue))
        }
        
    }
}

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "plus"
    case subtract = "minus"
    case divide = "divide"
    case multiply = "multiply"
    case equal = "equal"
    case clear = "AC"
    case doubleZero = "00"
    case del = "delete.left"
    case decimal = "."
    
    
    var buttonColor: Color {
        switch self {
        case .divide, .multiply, .subtract, .add:
            return Color("grayColor")
        case .clear, .del:
            return .red
        case .equal:
            return Color("orangeColor")
        default:
            return Color("darkGrayColor")
        }
    }
    
    var fontColor: Color {
        switch self {
        case .divide, .multiply, .subtract, .add:
            return .black
        default:
            return .white
        }
    }
    
    var isText: Bool {
        switch self {
        case .del, .divide, .multiply, .subtract, .add, .equal:
            return false
        default:
            return true
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

