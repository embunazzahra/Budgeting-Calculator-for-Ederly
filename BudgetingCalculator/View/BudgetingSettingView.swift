//
//  BudgetingView.swift
//  Calculator
//
//  Created by Kevin Fairuz on 10/07/24.
//

import SwiftUI

struct BudgetSettingsView: View {
    @ObservedObject var viewModel: BudgetViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack(alignment: .center, spacing: 10){
                    VStack{
                        AmountBudget(viewModel: viewModel).padding(.bottom,20)
                        
                            .padding()
                    }
                    
                    ForEach(ExpenseCategory.allCases) { category in
                        NavigationLink(destination: InputSetBudget(category: category, onDismiss: {
                            viewModel.fetchBudgetCategories()
                        })) {
                            ButtonUpdateBudget(category: category, viewModel: viewModel)
                            
                        }
                        
                    }
                }
                
            }
            .padding(.bottom, 60)
            .frame(height: 600)
            
            .navigationTitle("Set Monthly Budget ").navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    BudgetSettingsView(viewModel: BudgetViewModel(dataSource: .shared))
}
