//
//  AllHistoryView.swift
//  BudgetingCalculator
//
//  Created by Dhau Embun Azzahra on 15/07/24.
//

import SwiftUI

struct AllHistoryView: View {
    @StateObject var modelView: AllHistoryViewModel
    
    init() {
        _modelView = StateObject(wrappedValue: AllHistoryViewModel(dataSource: .shared))
    }
    
    var body: some View {
        NavigationView {
            List(modelView.expenses) { expense in
                VStack(spacing: 0){
                    Divider()
                    HStack(alignment: .center){
                        HistoryCategoryIcon(category: expense.category)
                        Spacer().frame(width: 20)
                        Text("\(expense.category.rawValue)")
                        Spacer()
                        Spacer()
                        Text("IDR\(expense.amount, specifier: "%.f")")
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                            .fontWeight(.semibold)
                    }
                    .padding(.top,20)
//                    .frame(height: 50)
//                    .listRowSeparator(.hidden)
//                    Divider()
                }
//                .frame(height: 35)
                .listRowSeparator(.hidden)
                
            }
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    AllHistoryView()
}
