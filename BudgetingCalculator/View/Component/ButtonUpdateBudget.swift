//
//  ButtonUpdateBudget.swift
//  BudgetingCalculator
//
//  Created by Kevin Fairuz on 11/07/24.
//

import SwiftUI

struct ButtonUpdateBudget: View {
    let category: ExpenseCategory
    @ObservedObject var viewModel:BudgetViewModel
    
    var body: some View {
        
            HStack() {
                Image(systemName: category.icon)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                
                VStack(alignment: .leading){
                    Text(category.localizedString)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    
                    Text("IDR \(viewModel.allocatedBudgetForCategory(category), specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                Spacer()
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.white)
                
                
            }
            .padding()
            .background(category.color)
            .cornerRadius(10)
            .frame(width: 333,height: 81)

            
    }
}

#Preview {
    ButtonUpdateBudget(category: .health, viewModel: BudgetViewModel(dataSource: .shared))
}
