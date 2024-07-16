//
//  AmountBudget.swift
//  BudgetingCalculator
//
//  Created by Kevin Fairuz on 11/07/24.
//

import SwiftUI

struct AmountBudget: View {
    var body: some View {
        
        VStack(alignment: .center) {
            
            Text("Amount Budget")
            
            
                .background(Color(.systemGray4))
            Divider().foregroundColor(.white)
            
            VStack(){
                Text("")
                }
            }
        .frame(width: 335, height: 88)
        .background(Color(.whiteBlue))
            .cornerRadius(15)
            
        

    }
}

#Preview {
    AmountBudget()
}
