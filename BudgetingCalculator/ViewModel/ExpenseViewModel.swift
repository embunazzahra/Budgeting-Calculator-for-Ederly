//
//  ExpenseViewMode.swift
//  BudgetingCalculator
//
//  Created by Kevin Fairuz on 12/07/24.
//

import Foundation
import SwiftUI
import SwiftData


class ExpenseViewModel: ObservableObject {
    private let dataSource: SwiftDataService
    @Published var expenses: [Expense] = []
    
    init(dataSource: SwiftDataService) {
        self.dataSource = dataSource
        
        // Add dummy expenses to the SwiftData to see if fetching data is works
    }
    
    

    
}


