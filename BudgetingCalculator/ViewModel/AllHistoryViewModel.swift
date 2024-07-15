//
//  AllHistoryViewModel.swift
//  BudgetingCalculator
//
//  Created by Dhau Embun Azzahra on 15/07/24.
//

import Foundation

import SwiftUI
import SwiftData

class AllHistoryViewModel: ObservableObject {
    private let dataSource: SwiftDataService
    @Published var expenses: [Expense] = []
    @Published var selectedDate = Date()
    @Published var currentWeek: [Date] = []
    
    init(dataSource: SwiftDataService){
        self.dataSource = dataSource
        initializeExpenses()
        fetchCurrentWeek() 
    }
    
    private func initializeExpenses(){
        if dataSource.fetchExpenses().isEmpty{
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
    
    func fetchCurrentWeek(){
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else{
            return
        }
        
        (1...7).forEach{
            day in
            
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekday)
            }
                
        }
        
    }
    
    func extractDate(date: Date, format: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    func isToday(date: Date) -> Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(selectedDate, inSameDayAs: date)
    }
    
}
