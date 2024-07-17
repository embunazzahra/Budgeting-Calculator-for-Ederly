//
//  CircleCategory.swift
//  BudgetingCalculator
//
//  Created by Kevin Fairuz on 12/07/24.
//

import SwiftUI

struct CircleCategory: View {
    let category: ExpenseCategory
    @ObservedObject var viewModel: BudgetViewModel
    
    var body: some View {
        
            ZStack {
                Rectangle()
                    .fill(category.color)
                    .frame(width: 181, height: 277)
                    .cornerRadius(25)

                    VStack{
                        Image(systemName: category.icon)
                            .font(.system(size: 48))
                            .foregroundColor(.white)
                            .padding(.bottom, 2)
                        
                        
                        
                        Text(category.localizedString)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.font)
                    }
                        
                
            
        }
    }
}

#Preview {
    CircleCategory(category: .health, viewModel: BudgetViewModel(dataSource: .shared))
}
