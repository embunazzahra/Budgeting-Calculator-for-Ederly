//
//  IncomeView.swift
//  BudgetingCalculator
//
//  Created by Kevin Fairuz on 10/07/24.
//

import SwiftUI

struct IncomeView: View {
    let category: ExpenseCategory
    let income: Int = 10000
    @ObservedObject var viewModel: IncomeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Image(systemName: category.icon)
                .font(.largeTitle)
                .foregroundColor(.white)
                
            Text(category.localizedString)
                .font(.headline)
                .foregroundColor(.white)
        
            
            Text("IDR \(income)")
                .font(.subheadline)
                .foregroundColor(.white)
                
            
    
        }
        .offset(x: -20)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 150)
        .background{
            VStack(alignment: .leading, spacing: 10) {
                ZStack(alignment: .leading){
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 140, height: 108)
                        .background(category.colorBack)
                        .cornerRadius(8)
                        .offset(y: -10)
                
                
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 155, height: 112)
                        .background(category.color)
                        .cornerRadius(8)
                    VStack(alignment: .trailing) {
                        
                        Rectangle()
                          .foregroundColor(.clear)
                          .frame(width: 44, height: 38)
                          .background(Image(systemName: "plus.circle.fill").font(Font.custom("SF Pro", size: 20).weight(.semibold)))
                          .background(.white)
                          .clipShape(RoundedCornersShape(radius: 20, corners: [.topLeft, .bottomLeft]))
                        

                          
                    }
                    .offset(x: 112)
                }.padding()
                    .padding(.horizontal, 5)
                
            }
                
            
            
            .cornerRadius(10)
            .frame(width: 205, height: 150, alignment: .topLeading)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        }
        
//        .onTapGesture {
//            // self.$viewModel.selectedCategory.wrappedValue = category // Corrected access
//            viewModel.selectedCategory = category // Directly assign the value
//            viewModel.isCalculatorSheetPresented = true
//        }
    }
}


