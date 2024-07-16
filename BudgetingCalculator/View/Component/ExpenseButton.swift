//
//  ExpenseButton.swift
//  BudgetingCalculator
//
//  Created by Kevin Fairuz on 12/07/24.
//

import SwiftUI

struct ExpenseButton: View {
    @State var isPresentCategoryExpense = false
    @ObservedObject var viewModel: BudgetViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                VStack() {
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: {
                            isPresentCategoryExpense = true
                        }) {
                            VStack{
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 54))
                                    .clipShape(Circle())
                                    .foregroundColor(.orange)
                                    .padding(.top,100)
                                
                                Text("Add Expenses")
                                    .font(.system(size: 12))
                                
                                
                            }
                            
                        }
                        .padding(.bottom, geometry.safeAreaInsets.bottom + 20)
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                            .sheet(isPresented: $isPresentCategoryExpense){
                                ChooseCategorySheet(viewModel: viewModel, isPresented: $isPresentCategoryExpense)
                                    .onDisappear{
                                        print("Test")
                                        viewModel.triggerRefresh.toggle()
                                        print(viewModel.triggerRefresh)
                                    }
                            }
                    }
                    
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        
        
        
        
    }
}

#Preview {
    ExpenseButton(viewModel: BudgetViewModel(dataSource: .shared))
}
