//
//  ModelTrack.swift
//  Calculator
//
//  Created by Kevin Fairuz on 08/07/24.
//

import SwiftData
import Foundation
import SwiftUI


@Model
final class Expense {
    var id: UUID
    var category: ExpenseCategory
    var amount: Double
    var date: Date

    init(id: UUID = UUID(), category: ExpenseCategory, amount: Double, date: Date = Date()) {
        self.id = id
        self.category = category
        self.amount = amount
        self.date = date
    }
}

enum ExpenseCategory: String, CaseIterable, Codable, Identifiable {
    case household = "Household"
    case health = "Medical"
    case other = "Others"
    case savings = "Savings"

    var id: String { self.rawValue }
    
    var localizedString: LocalizedStringKey {
        switch self {
        case .household:
            return LocalizedStringKey("household")
        case .health:
            return LocalizedStringKey("health")
        case .other:
            return LocalizedStringKey("other")
        case .savings:
            return LocalizedStringKey("savings")
        }
    }

    var icon: String {
        switch self {
        case .household: return "cart.fill"
        case .health: return "cross.fill"
        case .other: return "car"
        case .savings: return "creditcard"
        }
    }
    
    var color: Color {
        switch self {
        case .household: return .brightOrange
        case .health: return .turquoise
        case .other: return .darkRed 
        case .savings: return .lightBlue
        }
    }
    
    var colorBack: Color {
        switch self {
        case .household: return .lightOrange
        case .health: return .lightcyan
        case .other: return  .lightRed
        case .savings: return .skyBlue
        }
    }
}



