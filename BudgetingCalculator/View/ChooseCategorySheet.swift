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
    @Binding var isPresented: Bool // Tambahkan in

    var body: some View {
        NavigationView {
            ZStack{
                VStack{
                    
                    LazyVGrid(columns: [GridItem(.flexible(),spacing: 0), GridItem(.flexible())], spacing: 15) {
                        ForEach(ExpenseCategory.allCases) { category in
                            NavigationLink(destination: CalcView( category: category,onDismiss: {
                                self.isPresented = false // Menutup ChooseCategorySheet
                                viewModel.refreshData()
                            })){
                                CircleCategory(category: category, viewModel: viewModel)
//                                    .onTapGesture {
//                                        viewModel.selectedCategory = category
//                                        viewModel.isCalculatorSheetPresented = true
//                                    }
                            }
                        }
                    }
                    
//                    .padding()
                }
                

                .padding(.bottom, 50)
                    .navigationTitle("Choose Category")
            }
                
            }
        }
    }


#Preview {
    ChooseCategorySheet(viewModel: BudgetViewModel(dataSource: .shared), isPresented: .constant(true))
}

