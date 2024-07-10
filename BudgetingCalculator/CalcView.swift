//
//  CalcView.swift
//  BudgetingCalculator
//
//  Created by Dhau Embun Azzahra on 10/07/24.
//

import SwiftUI

struct CalcView: View {
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    @State var isTypingNumber = false
    @State var calcHistory = ""
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                // Text display result calculation
                HStack {
                    Spacer()
                    Text(calcHistory)
                        .bold()
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                }
                .padding()
                
                // Text display result calculation
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding()
                
                // Our buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func didTap(button: CalcButton) {
        calcHistory += button.rawValue
        switch button {
        case .add, .subtract, .multiply, .divide:
            if currentOperation != .none {
                let runningValue = runningNumber
                let currentValue = Int(value) ?? 0
                switch currentOperation {
                case .add: runningNumber = runningValue + currentValue
                case .subtract: runningNumber = runningValue - currentValue
                case .multiply: runningNumber = runningValue * currentValue
                case .divide: runningNumber = runningValue / currentValue
                case .none: break
                }
                value = "\(runningNumber)"
                
                
            } else {
                runningNumber = Int(value) ?? 0
            }
            
            switch button {
            case .add: currentOperation = .add
            case .subtract: currentOperation = .subtract
            case .multiply: currentOperation = .multiply
            case .divide: currentOperation = .divide
            default: break
            }
            isTypingNumber = false
        case .equal:
            let runningValue = runningNumber
            let currentValue = Int(value) ?? 0
            switch currentOperation {
            case .add: value = "\(runningValue + currentValue)"
            case .subtract: value = "\(runningValue - currentValue)"
            case .multiply: value = "\(runningValue * currentValue)"
            case .divide: value = "\(runningValue / currentValue)"
            case .none: break
            }
            currentOperation = .none
            runningNumber = 0
        case .clear:
            value = "0"
            runningNumber = 0
            currentOperation = .none
            isTypingNumber = false
            calcHistory = ""
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if isTypingNumber {
                value += number
            } else {
                value = number
                isTypingNumber = true
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
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
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
    
    var symbol: String {
            switch self {
            case .add: return "+"
            case .subtract: return "-"
            case .multiply: return "x"
            case .divide: return "÷"
            case .none: return ""
            }
        }
}

#Preview {
    CalcView()
}
