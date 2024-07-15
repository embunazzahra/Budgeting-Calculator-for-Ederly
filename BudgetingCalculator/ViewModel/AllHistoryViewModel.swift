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
    @Published var weekSlider: [[WeekDay]] = []
    @Published var currentWeekIndex: Int = 1
    @Published var firstDate: Date = Date()
    @Published var lastDate: Date = Date()
    
    init(dataSource: SwiftDataService){
        self.dataSource = dataSource
        initializeExpenses()
        let currentWeek = fetchWeek()
        
        if let firstDate = currentWeek.first?.date{
            weekSlider.append(createPreviousWeek(firstDate))
        }
        
        weekSlider.append(currentWeek)
        
        if let lastDate = currentWeek.last?.date{
            weekSlider.append(createNextWeek(lastDate))
        }
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
    

    
    
    
    func extractDate(date: Date, format: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    func isToday(date: Date) -> Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(selectedDate, inSameDayAs: date )
    }
    
    func fetchWeek(_ date: Date = .init()) -> [WeekDay]{

        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: date)
        
        var week: [WeekDay] = []
        
        let weekForDate = calendar.dateInterval(of: .weekOfMonth, for: startOfDate)
        
        guard let startOfWeek = weekForDate?.start else{
            return []
        }
        
        (1...7).forEach{
            day in
            
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeek){
                week.append(.init(date: weekday))
            }
                
        }
        return week
        
    }
    
    
    //creating previous week based on first current week's date
    func createPreviousWeek(_ date: Date) -> [WeekDay]{
        let calendar = Calendar.current
        let startOfFirstDate = calendar.startOfDay(for: date)
        
        guard let previousDate = calendar.date(byAdding: .day, value: -2, to: startOfFirstDate) else{
            return []
        }
        
        return fetchWeek(previousDate)
    }
    
    //creating next week based on last current week's date
    func createNextWeek(_ date: Date) -> [WeekDay]{
        let calendar = Calendar.current
        let startOfLastDate = calendar.startOfDay(for: date)
        
        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfLastDate) else{
            return []
        }
        
        return fetchWeek(nextDate)
    }
    
}


    
    
    struct WeekDay: Identifiable{
        var id: UUID  = .init()
        var date: Date
    }



