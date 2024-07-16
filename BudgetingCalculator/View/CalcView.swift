//
//  CalcView.swift
//  BudgetingCalculator
//
//  Created by Dhau Embun Azzahra on 10/07/24.
//

import SwiftUI

struct CalcView: View {
    
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
                    ProgressBarView(progress: $modelView.progress, color: modelView.progressBarColor(category: category))
                    
                    //progress bar
                    HStack{
                        //remaining budget
                        VStack(alignment: .leading){
                            Text("Remaining budget")
                                .font(.system(size: 15))
                                .foregroundColor(Color("graylabel"))
                            Text("Rp \(modelView.runningBudget, specifier: "%.f")")
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                                .foregroundColor(Color("graylabel"))
                        }
                        
                        Spacer()
                        
                        //expenses
                        VStack(alignment: .leading){
                            Text("Expenses")
                                .font(.system(size: 15))
                                .foregroundColor(Color("graylabel"))
                            Text("Rp \(modelView.runningExpense, specifier: "%.f")")
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                                .foregroundColor(Color("graylabel"))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical,10)
    //                .background(Color("yellowFFCF23"))
                }
                
                
                
                
                
                //calculator
                VStack{
                    HStack{
                        // Our buttons
                        ForEach(modelView.buttons, id: \.self) { row in
                            VStack(spacing: 12) {
                                ForEach(row, id: \.self) { item in
                                    Button(action: {
                                        self.modelView.didTap(button: item)
                                        
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
                .padding()
                .background(Color("grayF4F4F4"))
                
                
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
    CalcView(category: .health)
}
