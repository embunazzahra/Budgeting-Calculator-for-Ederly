//
//  ExpenseRowView.swift
//  BudgetingCalculator
//
//  Created by Michael Varian Kostaman on 16/07/24.
//

import SwiftUI

//struct ExpenseRowView: View {
//    let expense: Expense
//    
//    var body: some View {
//        VStack (alignment: .leading) {
//            Text(formattedDate)
//                .fontWeight(.semibold)
//                .padding(.bottom, 10)
//            
//            HStack {
//                // Icon
//                ZStack {
//                    Circle()
//                        .foregroundColor(expense.category.color)
//                        .frame(width: 40, height: 40)
//                    
//                    Image(systemName: expense.category.icon)
//                        .font(.system(size: 20))
//                        .foregroundColor(.white)
//                }
//                
//                
//                // Name
//                Text("\(expense.category.rawValue)")
//                
//                Spacer()
//                
//                Text("-IDR \(expense.amount, specifier: "%.f")")
//                    .foregroundColor(Color.red)
//                    .fontWeight(.semibold)
//            }
//        }
//        //        .padding(.vertical, 5)
//        .padding(.vertical, 10)
//        .padding(.horizontal, 20)
//    }
//    
//    private var formattedDate: String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "E, d MMM"
//        return formatter.string(from: expense.date)
//    }
//}
