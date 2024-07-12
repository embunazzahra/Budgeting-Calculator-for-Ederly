//
//  Balance.swift
//  BudgetingCalculator
//
//  Created by Michael Varian Kostaman on 11/07/24.
//

import SwiftUI
import SwiftData
import Foundation

@Model
final class Balance {
    var id: UUID
    var accountBalance: Int
    
    init(id: UUID = UUID(), accountBalance: Int) {
        self.id = id
        self.accountBalance = accountBalance
    }
}

