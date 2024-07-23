//
//  AddExpenseViewModel.swift
//  BudgetingCalculator
//
//  Created by Dhau Embun Azzahra on 12/07/24.
//

import SwiftUI
import SwiftData

class AddExpenseViewModel: ObservableObject {
    private let dataSource: SwiftDataService
    var value = "0"
    var remainingBudget = 0.0
    var budgetCategories: [BudgetCategory] = []
    var isCalculating = false
    var convertedValue = "0"
    @Published var runningNumber = 0
    @Published var calcHistory = ""
    @Published var progress = 0.7
    @Published var expenses: [Expense] = []
    @Published var runningExpense = 0.0
    @Published var runningBudget = 0.0
    @Published var category: ExpenseCategory
    @Published var expense = 0.0
    @Published var budget = 0.0
    @Published var isFinished = false
    @Published var currPage = 1 // 1 -> CalcView, 2 -> InputSetBudget
    @Published var displayText = ""
    private let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    


    func triggerHapticFeedback() {
        lightImpactFeedbackGenerator.impactOccurred()
    }
    
    
    init(dataSource: SwiftDataService, category: ExpenseCategory) {
        self.dataSource = dataSource
        self.category = category
        initializeDummyExpensesCategories()
        initializeDummyBudgetCategories()
        initializeProgress(self.category)
    }
    
    private func initializeDummyExpensesCategories() {
        if dataSource.fetchExpenses().isEmpty {
            let dummyExpenses = [
                Expense(category: .household, amount: 300000.0),
                Expense(category: .household, amount: 100000.0),
                Expense(category: .health, amount:500000.0),
                Expense(category: .other, amount:200000.0),
                Expense(category: .savings, amount:20000.0),
            ]
            for expense in dummyExpenses {
                dataSource.addExpense(expense)
            }
        }
        self.expenses = dataSource.fetchExpenses()
    }
    
    private func initializeDummyBudgetCategories() {
        if dataSource.fetchBudgetCategory().isEmpty{
            let dummyCategories = [
                BudgetCategory(category: .household, allocatedAmount: 2600000.0),
                BudgetCategory(category: .health, allocatedAmount: 3000000.0),
                BudgetCategory(category: .other, allocatedAmount: 5000000.0),
                BudgetCategory(category: .savings, allocatedAmount: 1500000.0)
            ]
            
            for budget in dummyCategories {
                dataSource.addBudgetCategory(budget)
            }
            
        }
        
        //nanti ganti dummyCategories ke fetchBudgetCategory
        self.budgetCategories = dataSource.fetchBudgetCategory()
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
    
    
    func getAllocatedBudget(_ category: ExpenseCategory) -> Double {
        let categoryBudget = budgetCategories.first(where: { $0.category == category })?.allocatedAmount ?? 0
        return categoryBudget
    }
    
    func initializeProgress(_ category: ExpenseCategory) {
        self.budget = getAllocatedBudget(category)
        self.remainingBudget = remainingBudgetForCategory(category)
        self.expense = totalExpensesForCategoryThisMonth(category: category)
        
        if budget <= 0.0{
            self.progress = 0.5
        }
        else{
            self.progress = (1-(expense/budget))
            self.runningExpense = expense
            self.runningBudget = remainingBudget
        }
        
    }
    
    func updateProgress() {
        if budget <= 0.0{
            self.progress = 0.5
        }
        else{
            self.progress = (1-(runningExpense/budget))
        }
    }
    
    func updateRunningExpense(value: Double) {
        let newExpense = expense + value
        self.runningExpense = newExpense
    }
    
    func updateRunningBudget(value: Double) {
        let newBudget = remainingBudget - value
        self.runningBudget = newBudget
    }
    
    func addExpense(category: ExpenseCategory, amount: Double){
        let newExpense = Expense(category: category, amount: amount)
        dataSource.addExpense(newExpense)
    }
    
    let buttons: [[CalcButton]] = [
        [.clear, .one, .four, .seven, .zero],
        [.divide, .two, .five, .eight, .doubleZero],
        [.multiply, .three, .six, .nine, .decimal],
        [.del, .subtract, .add, .equal],
    ]
    
    
    
    
    func didTap(button: CalcButton, currPage: Int, category: ExpenseCategory) {
        var convertedIcon = ""
        
        triggerHapticFeedback()
        
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
            
            convertedIcon = ","
            convertedValue += "."
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
                calcHistory = displayText
                value = calculateExpression(expression: convertedValue)
                convertedValue = value
                
                if !isCalculating {
                    if (currPage == 1){
                        addExpense(category: category, amount: Double(value) ?? 0.0)
                        initializeDummyExpensesCategories()
                        initializeDummyBudgetCategories()
                        self.isFinished = true
                    } else {
                        self.isFinished = true
                        dataSource.updateBudgetCategory(category: category, newAllocatedAmount: Double(value) ?? 0.0)
                        let x = dataSource.fetchBudgetCategory()
                        for budget in x {
                            print("Category: \(budget.category), Allocated Amount: \(budget.allocatedAmount)")
                        }
                    }
                    
                }
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
                print(convertedValue)
                self.updateRunningExpense(value: convertedValue)
                self.updateRunningBudget(value: convertedValue)
                self.updateProgress()
                
                
            }
            
        }
        
        displayText = formatNumbersInExpression(value) // Update the value to formatted value
        
        
    }
    
    func formatNumbersInExpression(_ expression: String) -> String {
        // Regular expression pattern to match numbers, including decimal parts
        let pattern = "\\d+(?:,\\d+)?"
        var formattedExpression = expression
        
        // Function to format a single number
        func formatNumber(_ number: String) -> String? {
            let components = number.split(separator: ",")
            let integerPart = String(components[0])
            let decimalPart = components.count > 1 ? "," + components[1] : ""
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = "."
            formatter.locale = Locale(identifier: "id_ID")
            
            if let integerNumber = Double(integerPart) {
                if let formattedIntegerPart = formatter.string(from: NSNumber(value: integerNumber)) {
                    return formattedIntegerPart + decimalPart
                }
            }
            return nil
        }
        
        // Use NSRegularExpression to find and format numbers
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let matches = regex.matches(in: expression, options: [], range: NSRange(location: 0, length: expression.utf16.count))
            
            // Iterate over matches in reverse order to avoid messing up the string indices
            for match in matches.reversed() {
                if let range = Range(match.range, in: expression) {
                    let number = String(expression[range])
                    if let formattedNumber = formatNumber(number) {
                        formattedExpression.replaceSubrange(range, with: formattedNumber)
                    }
                }
            }
        } catch {
            print("Invalid regular expression")
        }
        
        return formattedExpression
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
            return .calcBackHouse
        case .health:
            return .calcBackMedical
        case .savings:
            return .calcBackSaving
        case .other:
            return .calcBackOther
        }
    }
    
    func progressBarColor (category: ExpenseCategory) -> Color{
        switch category{
        case .household:
            return Color.yellowFFCF23
        case .health:
            return Color.turquoise
        case .savings:
            return Color.blue
        case .other:
            return Color.magenta
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
    case decimal = ","
    
    
    var buttonColor: Color {
        switch self {
        case .divide, .multiply, .subtract, .add:
            return Color("grayColor")
        case .clear, .del:
            return .red
        case .equal:
            return .calculator
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

