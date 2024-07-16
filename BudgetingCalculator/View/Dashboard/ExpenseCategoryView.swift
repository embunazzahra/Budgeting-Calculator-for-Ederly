//
//  ExpenseCategoryView.swift
//  Calculator
//
//  Created by Kevin Fairuz on 10/07/24.
//

import SwiftUI

struct ExpenseCategoryView: View {
    let category: ExpenseCategory
    @ObservedObject var viewModel: BudgetViewModel
    
    var body: some View {
        NavigationLink(destination: HistoryCategoryView(category: category, viewModel: viewModel)) {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Image(systemName: category.icon)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        
                        Text(category.localizedString)
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("IDR \(viewModel.remainingBudgetForCategory(category), specifier: "%.2f")")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                    .padding(.leading, 20)
                    Spacer()
                }
            }
            .offset(x: -20)
            .padding([.top, .bottom], 16)
            .padding(.trailing, 0)
            .padding(.leading, 10)
            .background {
                VStack(alignment: .leading, spacing: 10) {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 140, height: 108)
                            .background(category.colorBack)
                            .cornerRadius(8)
                            .offset(y: -15)
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 155, height: 112)
                            .background(category.color)
                            .cornerRadius(8)
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 44, height: 38)
                            .background(.white)
                            .clipShape(RoundedCornersShape(radius: 20, corners: [.topLeft, .bottomLeft]))
                            .offset(x: 112)
                    }
                    .padding()
                    .padding(.horizontal, 5)
                }
                .cornerRadius(10)
                .frame(width: 205, height: 150, alignment: .topLeading)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            }
        }
        .buttonStyle(PlainButtonStyle()) // Use this to ensure the navigation link looks like the original view
    }
}



#Preview {
    ExpenseCategoryView(category: .health, viewModel: BudgetViewModel(dataSource: .shared))
}
