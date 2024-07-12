//
//  CircleCategory.swift
//  BudgetingCalculator
//
//  Created by Kevin Fairuz on 12/07/24.
//

import SwiftUI

struct CircleCategory: View {
    let category: ExpenseCategory
    @ObservedObject var viewModel = BudgetViewModel(dataSource: .shared)
    
    var body: some View {
        
            ZStack {
                Circle()
                    .fill(category.color)
                    .frame(width: 151, height: 151)
                    VStack{
                        Image(systemName: category.icon)
                            .font(.system(size: 48))
                            .foregroundColor(.white)
                            .padding(.bottom, 2)
                        
                        
                        
                        Text(category.rawValue)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                        
                
            
        }
    }
}

#Preview {
    CircleCategory(category: .health)
}