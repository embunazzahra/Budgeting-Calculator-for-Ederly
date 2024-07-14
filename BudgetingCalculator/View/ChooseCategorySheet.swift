//
//  ChooseCategorySheet.swift
//  BudgetingCalculator
//
//  Created by Kevin Fairuz on 12/07/24.
//

import SwiftUI
    
struct ChooseCategorySheet: View {
    @ObservedObject var viewModel: BudgetViewModel
//    @Binding var showPopup: Bool
    @Environment(\.dismiss) var dismiss // Untuk menutup sheet
    @State var isPresentCategoryExpense = false

    var body: some View {
        NavigationView {
            ZStack{
                VStack(spacing: 20) {
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(ExpenseCategory.allCases) { category in
                            NavigationLink(destination: CalcView( category: category)){
                                CircleCategory(category: category, viewModel: viewModel)
                                    .onTapGesture {
                                        viewModel.selectedCategory = category
                                        viewModel.isCalculatorSheetPresented = true
                                    }
                            }
                        }
                    }
                    .padding()
                }.padding(.bottom, 50)
                    .navigationTitle("Choose Category")
            }
                
            }
        }
    }


#Preview {
    ChooseCategorySheet(viewModel: BudgetViewModel(dataSource: .shared))
}

