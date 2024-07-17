//
//  AmountBudget.swift
//  BudgetingCalculator
//
//  Created by Kevin Fairuz on 11/07/24.
//

import SwiftUI

struct AmountBudget: View {
    @ObservedObject var viewModel: BudgetViewModel
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            Text("Amount Budget")
                .foregroundColor(Color.black)
            
            VStack(){
                Text(String(format: "IDR%.2f", viewModel.totalBudget()))
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.black)
            }
        }
        
        .frame(width: 335, height: 88)
        .background(.amountBudget)
        .cornerRadius(15)
        
        
        
    }
}

#Preview {
    AmountBudget(viewModel: BudgetViewModel(dataSource: .shared))
}
