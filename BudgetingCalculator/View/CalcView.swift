//
//  CalcView.swift
//  BudgetingCalculator
//
//  Created by Dhau Embun Azzahra on 10/07/24.
//

import SwiftUI

struct CalcView: View {
    
    @StateObject var modelView = AddExpenseViewModel()
    
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
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)          .background(Color("yellowFFCF23").opacity(0.2))
                
                
                //progress bar
                HStack{
                    //remaining budget
                    VStack(alignment: .leading){
                        Text("Remaining budget")
                            .font(.system(size: 15))
                            .foregroundColor(Color("gray585858"))
                        Text("Rp 2.600.000")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color("gray585858"))
                    }
                    
                    Spacer()
                    
                    //expenses
                    VStack(alignment: .leading){
                        Text("Expenses")
                            .font(.system(size: 15))
                            .foregroundColor(Color("gray585858"))
                        Text("Rp 400.000")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color("gray585858"))
                    }
                }
                .padding(.horizontal)
                .padding(.vertical,10)
                .background(Color("yellowFFCF23"))
                
                
                
                //calculator
                VStack{
                    HStack{
                        // Our buttons
                        ForEach(modelView.buttons, id: \.self) { row in
                            VStack(spacing: 12) {
                                ForEach(row, id: \.self) { item in
                                    Button(action: {
                                        self.modelView.didTap(button: item)
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
    CalcView()
}
