//
//  BudgetViewModel.swift
//  Calculator
//
//  Created by Kevin Fairuz on 09/07/24.
//

import SwiftUI
import SwiftData

class BudgetViewModel: ObservableObject {
    private let dataSource: SwiftDataService
    @Published var expenses: [Expense] = []
    @Published var budgetCategories: [BudgetCategory] = []
    @Published var isDarkMode: Bool = false
    @Published var currentNumber: String = "0"
    @Published var isCalculatorSheetPresented = false
    @Published var isPresentCategoryExpense = false
    @Published var accountBalance = 10000000 // Initial Account Balance
    @Published var selectedCategory: ExpenseCategory?
    @Published var triggerRefresh: Bool = false
    
    init(dataSource: SwiftDataService) {
        self.dataSource = dataSource
        
        self.expenses = dataSource.fetchExpenses()
        self.budgetCategories = dataSource.fetchBudgetCategory()
        
        // Add dummy expenses to the SwiftData to see if fetching data is works
        if let balance = dataSource.fetchBalance() {
            self.accountBalance = balance.accountBalance
        } else {
            // If balance is not found, you might want to handle this case
            print("Balance not found")
        }
        
        initializeDummyBudgetCategories()
        initializeDummyExpensesCategories()
    }
    
    func refreshData(){
        self.expenses = dataSource.fetchExpenses()
        self.budgetCategories = dataSource.fetchBudgetCategory()
        
        // Add dummy expenses to the SwiftData to see if fetching data is works
        if let balance = dataSource.fetchBalance() {
            self.accountBalance = balance.accountBalance
        } else {
            // If balance is not found, you might want to handle this case
            print("Balance not found")
        }
        initializeDummyBudgetCategories()
        initializeDummyExpensesCategories()
    }
    func fetchBudgetCategories() {
        self.budgetCategories = dataSource.fetchBudgetCategory()
    }
    
//    func saveBudgetCategory(_ budgetCategory: BudgetCategory) {
//        if let index = budgetCategories.firstIndex(where: { $0.category == budgetCategory.category }) {
//            budgetCategories[index] = budgetCategory
//        } else {
//            budgetCategories.append(budgetCategory)
//        }
//        dataSource.saveBudgetCategories(budgetCategories)
//    }
    
    private func initializeDummyExpensesCategories() {
        if expenses.isEmpty {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"

            if dataSource.fetchExpenses().isEmpty {
                let dummyExpenses = [
                    Expense(category: .health, amount: 300000.0, date: dateFormatter.date(from: "2024/07/10")!),
                    Expense(category: .health, amount: 100000.0, date: dateFormatter.date(from: "2024/07/10")!),
                    Expense(category: .health, amount: 500000.0, date: dateFormatter.date(from: "2024/07/12")!),
                    Expense(category: .other, amount: 200000.0, date: dateFormatter.date(from: "2024/07/13")!),
                    Expense(category: .savings, amount: 200000.0, date: dateFormatter.date(from: "2024/07/14")!),
                    Expense(category: .household, amount: 200000.0, date: dateFormatter.date(from: "2024/07/11")!),
                    Expense(category: .household, amount: 500000.0, date: dateFormatter.date(from: "2024/07/13")!),
                ]
                for expense in dummyExpenses {
                    dataSource.addExpense(expense)
                }
            }
            self.expenses = dataSource.fetchExpenses()
        }
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
            
            //nanti ganti dummyCategories ke fetchBudgetCategory
        }
        self.budgetCategories = dataSource.fetchBudgetCategory()
    }
    
    func updateBalance(accountBalance: Int){
        self.accountBalance = accountBalance
        dataSource.updateAccountBalance(newBalance: accountBalance)
    }
    
    func deleteExpense(at offsets: IndexSet) {
//        for index in offsets {
///           modelContext.delete(expenses[index])
//        }
    }

    func addExpense(category: String, amount: Double) {
        let expenseCategory = ExpenseCategory(rawValue: category) ?? .other
        let newExpense = Expense(category: expenseCategory, amount: amount)
    }

    
    func expensesForCategoryAndDate(category: ExpenseCategory, date: Date) -> [Expense] {
            return expenses.filter {
                $0.category == category && Calendar.current.isDate($0.date, inSameDayAs: date)
            }
        }

    var totalExpenses: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }

    var remainingBalance: Double {
        max(0, Double(accountBalance) - totalExpenses)
    }

//    func angleForCategory(_ category: String) -> Double {
//        let filteredExpenses = expenses.filter { $0.category == category }
//        let categoryTotal = filteredExpenses.reduce(0) { $0 + $1.amount }
//        let proportion = totalExpenses > 0 ? categoryTotal / totalExpenses : 0
//        return proportion * 360
//    }


    func allocatedBudgetForCategory(_ category: ExpenseCategory) -> Double {
        let categoryBudget = budgetCategories.first(where: { $0.category == category })?.allocatedAmount ?? 0
        return categoryBudget
    }
    
    func totalBudget() -> Double {
        let totalBudget = budgetCategories.reduce(0) { $0 + $1.allocatedAmount }
        return totalBudget
    }

    func remainingBudgetForCategory(_ category: ExpenseCategory) -> Double {
        let categoryBudget = budgetCategories.first(where: { $0.category == category })?.allocatedAmount ?? 0
        let spent = expenses.filter { $0.category == category }.reduce(0) { $0 + $1.amount }
        return max(0, categoryBudget - spent)
    }
    
    func totalExpenseForCategory(_ category: ExpenseCategory) -> Double {
        let spent = expenses.filter { $0.category == category }.reduce(0) { $0 + $1.amount }
        return spent
    }
    
    func expensesGroupedByDate(for category: ExpenseCategory) -> [Date: [Expense]] {
        let filteredExpenses = expenses.filter { $0.category == category }
        var groupedExpenses = [Date: [Expense]]()
        
        for expense in filteredExpenses {
            let startOfDay = Calendar.current.startOfDay(for: expense.date)
            if var existingExpenses = groupedExpenses[startOfDay] {
                existingExpenses.append(expense)
                groupedExpenses[startOfDay] = existingExpenses
            } else {
                groupedExpenses[startOfDay] = [expense]
            }
        }
        
        return groupedExpenses
    }
}
