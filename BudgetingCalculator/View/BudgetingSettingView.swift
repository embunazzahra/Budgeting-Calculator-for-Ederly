//
//  BudgetingView.swift
//  Calculator
//
//  Created by Kevin Fairuz on 10/07/24.
//

import SwiftUI

import SwiftUI

struct BudgetSettingsView: View {
    @ObservedObject var viewModel: BudgetViewModel
   

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack(alignment: .center, spacing: 10){
                    VStack{
                        AmountBudget().padding(.bottom,20)
                            
                        Divider()
                            .padding()
                    }
                    
                        ForEach(ExpenseCategory.allCases) { category in
                            NavigationLink(destination: BudgetDetail(viewModel: viewModel, category: category)){
                                ButtonUpdateBudget(category: category, viewModel: viewModel)
                                
                        }
                        
                    }
                }
                
            }
            .padding(.bottom, 60)
            .frame(height: 600)

                .navigationTitle("Budget Settings").navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    BudgetSettingsView(viewModel: BudgetViewModel(dataSource: .shared))
}
