//
//  InputSetBudget.swift
//  BudgetingCalculator
//
//  Created by Kevin Fairuz on 16/07/24.
//


import SwiftUI

struct InputSetBudget: View {
    @StateObject var modelView: AddExpenseViewModel
    @Environment(\.dismiss) var dismiss // Tambahkan ini
    let category: ExpenseCategory
    var onDismiss: (() -> Void)? // Tambahkan ini
    
    init(category: ExpenseCategory, onDismiss: (() -> Void)? = nil) {
        self.category = category
        self.onDismiss = onDismiss // Simpan onDismiss
        _modelView = StateObject(wrappedValue: AddExpenseViewModel(dataSource: .shared, category: category))
    }
    
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0){
                
                //display
                VStack(alignment: .center, spacing: 0){
                    
                    //history
                    HStack{
                        Text(modelView.calcHistory)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    
                    // Text display
                    HStack{
                        Text("IDR")
                            .bold()
                            .font(.system(size: 48))
                            .foregroundColor(.black)
                        Text(modelView.value)
                            .bold()
                            .font(.system(size: 48))
                            .foregroundColor(.black)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(modelView.calculatorColor(category: category).opacity(0.2))
                
                ZStack{
                    
                    
                    //calculator
                    VStack{
                        HStack{
                            // Our buttons
                            ForEach(modelView.buttons, id: \.self) { row in
                                VStack(spacing: 12) {
                                    ForEach(row, id: \.self) { item in
                                        Button(action: {
                                            self.modelView.didTap(button: item, currPage: 2, category: category)
                                            
                                            if modelView.isFinished { //
                                                dismiss()
                                                onDismiss?()
                                            }
                                        }, label: {
                                            modelView.getTextOrImage(for: item)
                                                .font(.system(size: 40))
                                                .frame(
                                                    width: self.buttonWidth(),
                                                    height: self.buttonHeight(item: item)
                                                )
                                                .background(item.buttonColor)
                                                .foregroundColor(item.fontColor)
                                                .cornerRadius(self.buttonWidth()/2)
                                        })
                                    }
                                }
                                //                            .padding(.bottom, 3)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("grayF4F4F4"))
                    
                }
            }
            
        }
        .navigationBarTitle(category.rawValue, displayMode: .inline) // 1
        .navigationBarBackButtonHidden(false)
        //        .navigationBarHidden(true)
    }
    
    
    
    func buttonWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight(item: CalcButton) -> CGFloat {
        if item == .equal{
            return ((UIScreen.main.bounds.width - (4*12)) / 4)*2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}


#Preview {
    InputSetBudget(category: .health)
}

