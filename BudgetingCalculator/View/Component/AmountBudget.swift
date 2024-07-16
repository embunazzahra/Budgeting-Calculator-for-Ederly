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
            
            Divider().foregroundColor(.white)
            
            VStack(){
                Text(String(format: "$%.2f", viewModel.totalBudget()))
                    .font(.headline)
                    .foregroundColor(.black)
            }
        }
        .frame(width: 335, height: 88)
        .background(Color(.whiteBlue))
        .cornerRadius(15)
        
        
        
    }
}

#Preview {
    AmountBudget(viewModel: BudgetViewModel(dataSource: .shared))
}
