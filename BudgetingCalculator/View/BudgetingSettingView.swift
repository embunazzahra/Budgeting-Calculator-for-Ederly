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
    @AppStorage("isCalculatorSheetPresented") private var isCalculatorSheetPresented = false // Add @AppStorage

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                Button(action: {
                    isCalculatorSheetPresented = true
                }){
                    Text("Add Budget")
                        
                    }
            }
                .navigationTitle("Budget Settings")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            viewModel.saveBudgetCategories()
                        }
                    }
                }

            .sheet(isPresented: $isCalculatorSheetPresented) { // Add the sheet modifier
                CalculatorSheet(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    BudgetSettingsView(viewModel: BudgetViewModel(dataSource: .shared))
}
