//
//  ModelTrack.swift
//  Calculator
//
//  Created by Kevin Fairuz on 08/07/24.
//

import SwiftData
import Foundation
import SwiftUICore

extension Color {
    static let turquoise = Color(red: 0.4627, green: 0.7569, blue: 0.7412) // #00C7BE
    static let lightBlue = Color(red: 0.1961, green: 0.6863, blue: 0.8863) // #32ADE6
    static let darkRed = Color(red: 0.6706, green: 0.1373, blue: 0.4588) // #AB2377
    static let brightOrange = Color(red: 1.0, green: 0.6235, blue: 0.0392) // #FF9F0A
    static let lightOrange = Color(red: 1.0, green: 0.8353, blue: 0.1412) // #FFCF23
    static let lightRed = Color(red: 0.9804, green: 0.5490, blue: 0.7882) // #FA89CF
    static let lightcyan = Color(red: 0.4706, green: 0.9961, blue: 0.9882) // #77FFF9
    static let skyBlue = Color(red: 0.4902, green: 0.8431, blue: 1.0) // #7CD5FF
}


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
    case household = "House Hold"
    case health = "Health"
    case other = "Others"
    case savings = "Saving"

    var id: String { self.rawValue }

    var icon: String {
        switch self {
        case .household: return "house.fill"
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

@Model
final class BudgetCategory {
    var id: UUID
    var category: ExpenseCategory
    var allocatedAmount: Double

    init(id: UUID = UUID(), category: ExpenseCategory, allocatedAmount: Double) {
        self.id = id
        self.category = category
        self.allocatedAmount = allocatedAmount
    }
}

