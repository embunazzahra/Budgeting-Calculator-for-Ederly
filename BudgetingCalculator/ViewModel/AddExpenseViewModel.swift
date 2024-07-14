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
    @Published var calcHistory = ""
    @Published var isCalculating = false
    var convertedValue = "0"
    @Published var progress = 0.7
    private let dataSource: SwiftDataService
    @Published var expenses: [Expense] = []
    @Published var budgetCategories: [BudgetCategory] = []
    @Published var runningExpense = 0.0
    @Published var runningBudget = 0.0
    @Published var category: ExpenseCategory
    @Published var expense = 0.0
    @Published var budget = 0.0
    
    init(dataSource: SwiftDataService, category: ExpenseCategory) {
        self.dataSource = dataSource
        self.category = category
        initializeDummyExpensesCategories()
        initializeDummyBudgetCategories()
        initializeProgress(self.category)
    }
    
    private func initializeDummyExpensesCategories() {
        if expenses.isEmpty {
            let dummyExpenses = [
                Expense(category: .household, amount: 300000.0),
                Expense(category: .household, amount: 100000.0),
                Expense(category: .health, amount:500000.0),
                Expense(category: .other, amount:200000.0),
                Expense(category: .savings, amount:20000.0),
            ]
            self.expenses = dummyExpenses
        }
    }
    
    private func initializeDummyBudgetCategories() {
        // Check if there are existing categories to avoid duplication
        if budgetCategories.isEmpty {
            let dummyCategories = [
                BudgetCategory(category: .household, allocatedAmount: 2600000.0),
                BudgetCategory(category: .health, allocatedAmount: 2000000.0),
                BudgetCategory(category: .other, allocatedAmount: 1500000.0),
                BudgetCategory(category: .savings, allocatedAmount: 100000.0)
            ]
            self.budgetCategories = dummyCategories
        }
    }
    
    func totalExpensesForCategoryThisMonth(category: ExpenseCategory) -> Double {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        
        let filteredExpenses = expenses.filter { expense in
            let expenseComponents = calendar.dateComponents([.year, .month], from: expense.date)
            return expense.category == category &&
            expenseComponents.year == components.year &&
            expenseComponents.month == components.month
        }
        
        let total = filteredExpenses.reduce(0) { $0 + $1.amount }
        return total
    }
    
    func remainingBudgetForCategory(_ category: ExpenseCategory) -> Double {
        let categoryBudget = budgetCategories.first(where: { $0.category == category })?.allocatedAmount ?? 0
        let spent = expenses.filter { $0.category == category }.reduce(0) { $0 + $1.amount }
        return max(0, categoryBudget - spent)
    }
    
    func initializeProgress(_ category: ExpenseCategory) {
        self.budget = remainingBudgetForCategory(category)
        self.expense = totalExpensesForCategoryThisMonth(category: category)
        
        if budget <= 0.0{
            self.progress = 0.5
        }
        else{
            self.progress = (1-(expense/budget))
            self.runningExpense = expense
            self.runningBudget = budget
        }
        
    }
    
    func updateProgress(value: Double, category: ExpenseCategory) {
        let newExpense = expense + value
        if budget <= 0.0{
            self.progress = 0.5
        }
        else{
            self.progress = (1-(newExpense/budget))
        }
    }
    
    func updateRunningExpense(value: Double) {
        let expense = totalExpensesForCategoryThisMonth(category: category)
        let newExpense = expense + value
        self.runningExpense = newExpense
    }
    
    func updateRunningBudget(value: Double) {
        let budget = remainingBudgetForCategory(category)
        let newBudget = budget - value
        self.runningBudget = newBudget
    }
    
    let buttons: [[CalcButton]] = [
        [.clear, .one, .four, .seven, .zero],
        [.divide, .two, .five, .eight, .doubleZero],
        [.multiply, .three, .six, .nine, .decimal],
        [.del, .subtract, .add, .equal],
    ]
    
    func didTap(button: CalcButton) {
        var convertedIcon = ""
        
        
        
        switch button{
        case .add:
            convertedIcon = "+"
            convertedValue += convertedIcon
            value += convertedIcon
            
        case .subtract:
            convertedIcon = "-"
            convertedValue += convertedIcon
            value += convertedIcon
            
        case .multiply:
            convertedIcon = "x"
            convertedValue += "*"
            value += convertedIcon
            
        case .divide:
            convertedIcon = "/"
            convertedValue += convertedIcon
            value += convertedIcon
        case .decimal:
            
            convertedIcon = "."
            convertedValue += convertedIcon
            value += convertedIcon
            
            
        case .zero:
            if value != "0" {
                convertedIcon = "0"
                convertedValue += "0"
                value += convertedIcon
            }
        case .doubleZero:
            if value != "0"{
                
                // Daftar operator yang ingin diperiksa
                let operators: Set<Character> = ["+", "-", "x", "/"]
                
                // Periksa apakah karakter terakhir adalah salah satu dari operator tersebut
                if !operators.contains(value.last!){
                    convertedIcon = "00"
                    convertedValue += "00"
                    value += convertedIcon
                }
                
                
            }
        case .clear:
            initializeProgress(category)
            value = "0"
            convertedValue = ""
            calcHistory = ""
   
        case .del:
            if !value.isEmpty {
  
                value.removeLast()
            }
            if !convertedValue.isEmpty {
                convertedValue.removeLast()
            }
            
        case .equal:
            if !value.isEmpty {
                calcHistory = value
                value = calculateExpression(expression: convertedValue)
                convertedValue = value
            }
            
        default:
            if value == "0" || value == "00"{
                value = ""
            }
            
            convertedValue += button.rawValue
            value += button.rawValue
        }
        
        if value.count >= 2 {
            value = doubleOperatorChecker(expression: value)
            convertedValue = doubleOperatorChecker(expression: convertedValue)
        }
        
        if value.isEmpty || convertedValue.isEmpty{
            value = "0"
            convertedValue = "0"
        }
        
        
        if(containsOperator(value)){
            isCalculating = true
            self.updateRunningExpense(value: 0.0)
        }else{
            isCalculating = false
            if let convertedValue = Double(value){
                self.updateProgress(value: convertedValue,category: category)
                self.updateRunningExpense(value: convertedValue)
                self.updateRunningBudget(value: convertedValue)
            }
            
        }
        
        
    }
    
    func doubleOperatorChecker(expression: String) -> String {
        var result = expression
        
        let lastChar = expression.last
        if expression.count >= 2 {
            let secondLastCharIndex = expression.index(expression.endIndex, offsetBy: -2)
            let secondLastChar = expression[secondLastCharIndex]
            
            // Memeriksa apakah keduanya adalah operator
            if let last = lastChar, let secondLast = secondLastChar as Character? {
                if "+-*/x.".contains(last) && "+-*/x.".contains(secondLast) {
                    // Hapus secondLastChar dari string result
                    result.remove(at: secondLastCharIndex)
                }
            }
        }
        
        return result
    }
    
    func calculateExpression(expression: String) -> String {
        
        let sanitizedExpression = sanitizeExpression(expression: expression)
        print(sanitizedExpression)
        let expression = NSExpression(format: sanitizedExpression)
        
        if let result = expression.expressionValue(with: nil, context: nil) as? NSNumber {
            let doubleResult = result.doubleValue
            
            if doubleResult.truncatingRemainder(dividingBy: 1) == 0 {
                // Jika hasilnya adalah bilangan bulat, format sebagai bilangan bulat
                return String(format: "%.0f", doubleResult)
            } else {
                // Jika hasilnya adalah bilangan desimal, biarkan dalam format desimal
                return String(doubleResult)
            }
        } else {
            return "Error"
        }
    }
    
    
    func sanitizeExpression(expression: String) -> String {
        // Remove leading or trailing operators
        let operators = CharacterSet(charactersIn: "+-*/")
        let modifiedExpression = expression.trimmingCharacters(in: operators)
        print(modifiedExpression)
        var sanitizedExpression = modifiedExpression.replacingOccurrences(of: "/", with: "*1.0/")
        print(sanitizedExpression)
        
        // Remove any invalid sequences
        let pattern = "[0-9]+([+-/*][0-9]+)*"
        let regex = try! NSRegularExpression(pattern: pattern)
        if let match = regex.firstMatch(in: sanitizedExpression, options: [], range: NSRange(location: 0, length: sanitizedExpression.count)) {
            if let range = Range(match.range, in: sanitizedExpression) {
                sanitizedExpression = String(sanitizedExpression[range])
            }
        }
        
        print(sanitizedExpression)
        
        return sanitizedExpression
    }
    
    func replaceDotsAfterFirstCharacter(in input: String) -> String {
        guard let dotRange = input.range(of: ".", options: .literal) else {
            return input
        }
        
        let firstPart = input[..<dotRange.upperBound]
        let secondPart = input[dotRange.upperBound...].replacingOccurrences(of: ".", with: "")
        
        return "\(firstPart)\(secondPart)"
    }
    
    
    
    func getTextOrImage(for button: CalcButton) -> AnyView {
        switch button{
        case .del, .divide, .multiply, .subtract, .add, .equal:
            if (button == .equal && !isCalculating){
                return AnyView(Image(systemName: "checkmark"))
            }
            return AnyView(Image(systemName: button.rawValue))
        default:
            return AnyView(Text(button.rawValue))
        }
        
    }
    
    func containsOperator(_ value: String) -> Bool {
        return value.contains("+") || value.contains("-") || value.contains("x") || value.contains("/")
    }
    
    func calculatorColor (category: ExpenseCategory) -> Color {
        switch category{
        case .household:
            return Color.yellowFFCF23
        case .health:
            return Color.green00C7BE
        case .savings:
            return Color.blue3EAFE5
        case .other:
            return Color.purpleAB2377
        }
    }
    
    func progressBarColor (category: ExpenseCategory) -> Color{
        switch category{
        case .household:
            return Color.yellowFFCF23
        case .health:
            return Color.green00C7BE
        case .savings:
            return Color.blue32ADE6
        case .other:
            return Color.purpleAB2377
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

