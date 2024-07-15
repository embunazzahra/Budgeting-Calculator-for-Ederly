//
//  HistoryCategoryIcon.swift
//  BudgetingCalculator
//
//  Created by Dhau Embun Azzahra on 15/07/24.
//

import SwiftUI

struct HistoryCategoryIcon: View {
    let category: ExpenseCategory
    
    var body: some View {
        
            ZStack {
                Circle()
                    .fill(category.color)
                    .frame(width: 50, height: 50)
                    VStack{
                        Image(systemName: category.icon)
                            .font(.system(size: 27))
                            .foregroundColor(.white)
                            .padding(.bottom, 2)
                        
                    }
        }
    }
}

#Preview {
    HistoryCategoryIcon(category: .savings)
}
