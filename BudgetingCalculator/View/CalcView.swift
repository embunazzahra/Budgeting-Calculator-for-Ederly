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
    
    
    let buttons: [[CalcButton]] = [
        [.clear, .one, .four, .seven, .zero],
        [.divide, .two, .five, .eight, .doubleZero],
        [.multiply, .three, .six, .nine, .decimal],
        [.del, .subtract, .add, .equal],
    ]
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0){
                
                //display
                VStack(alignment: .center, spacing: 0){
                    //history
                    HStack{
                        Text("200.000 x 2")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    
                    // Text display
                    HStack{
                        Text("IDR")
                            .bold()
                            .font(.system(size: 48))
                            .foregroundColor(.black)
                        Text(value)
                            .bold()
                            .font(.system(size: 48))
                            .foregroundColor(.black)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)                .background(Color("yellowFFCF23").opacity(0.2))
                
                
                
                //progress bar
                HStack{
                    //remaining budget
                    VStack(alignment: .leading){
                        Text("Remaining budget")
                            .font(.system(size: 15))
                            .foregroundColor(Color("gray585858"))
                        Text("Rp 2.600.000")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color("gray585858"))
                    }
                    
                    Spacer()
                    
                    //expenses
                    VStack(alignment: .leading){
                        Text("Expenses")
                            .font(.system(size: 15))
                            .foregroundColor(Color("gray585858"))
                        Text("Rp 400.000")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color("gray585858"))
                    }
                }
                .padding(.horizontal)
                .padding(.vertical,10)
                .background(Color("yellowFFCF23"))
                
                
                
                //calculator
                VStack{
                    HStack{
                        // Our buttons
                        ForEach(buttons, id: \.self) { row in
                            VStack(spacing: 12) {
                                ForEach(row, id: \.self) { item in
                                    Button(action: {
                                        self.didTap(button: item)
                                    }, label: {
                                        getTextOrImage(for: item)
                                            .font(.system(size: 40))
                                            .frame(
                                                width: self.buttonWidth(),
                                                height: self.buttonHeight(item: item)
                                            )
                                            .background(item.buttonColor)
                                            .foregroundColor(item.fontColor)
                                            .cornerRadius(self.buttonWidth()/2)
                                    })
                                }
                            }
                            //                            .padding(.bottom, 3)
                        }
                    }
                }
                .padding()
                .background(Color("grayF4F4F4"))
                
                
            }
            
        }
    }
    
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
    
    func buttonWidth() -> CGFloat {
//        if item == .equal {
//            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
//        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight(item: CalcButton) -> CGFloat {
        if item == .equal{
            return ((UIScreen.main.bounds.width - (4*12)) / 4)*2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func getTextOrImage(for value: CalcButton) -> AnyView {
        switch value{
        case .del, .divide, .multiply, .subtract, .add, .equal:
            return AnyView(Image(systemName: value.rawValue))
        default:
            return AnyView(Text(value.rawValue))
        }
        
//        if value == .del {
//            return AnyView(Image(systemName: value.rawValue))
//        } else {
//            return AnyView(Text(value.rawValue))
//        }
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
    case bracket = "()"
    case percent = "%"
    case decimal = "."
    //    case percent = "%"
    //    case negative = "-/+"
    
    var buttonColor: Color {
        switch self {
        case .divide, .multiply, .subtract, .add, .clear, .del, .bracket, .percent:
            return Color("grayColor")
        case .equal:
            return Color("orangeColor")
        default:
            return Color("darkGrayColor")
        }
    }
    
    var fontColor: Color {
        switch self {
        case .divide, .multiply, .subtract, .add, .clear, .del, .bracket, .percent:
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

#Preview {
    CalcView()
}
