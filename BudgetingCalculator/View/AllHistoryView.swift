//
//  AllHistoryView.swift
//  BudgetingCalculator
//
//  Created by Dhau Embun Azzahra on 15/07/24.
//

import SwiftUI

struct AllHistoryView: View {
    @StateObject var modelView: AllHistoryViewModel
    
    init() {
        _modelView = StateObject(wrappedValue: AllHistoryViewModel(dataSource: .shared))
    }
    
    var body: some View {
        NavigationView {
            VStack{
                LazyVStack(spacing:15,pinnedViews: [.sectionHeaders]){
                    Section{
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack(spacing:10){
                                ForEach(modelView.currentWeek, id:\.self){ day in
                                    VStack(spacing: 10){
                                        
                                        Text(modelView.extractDate(date: day, format: "EEE").prefix(1))
                                            .font(.system(size: 14))
                                            .fontWeight(.semibold)
                                        
                                        ZStack{
                                            Circle()
                                                .fill(.yellowFFCF23)
                                                .frame(width: 26,height: 26)
                                                .opacity(modelView.isToday(date: day) ? 1 : 0)
                                            
                                            Text(modelView.extractDate(date: day, format: "dd"))
                                                .font(.system(size: 14))
                                                .fontWeight(.regular)
                                        }
                                        
                                        
                                        
                                        
                                    }
                                    .frame(width: 45, height: 90)
                                    .background(
                                        Color.clear
                                    )
                                    .onTapGesture {
                                        withAnimation(.snappy){
                                            modelView.selectedDate = day
                                        }
                                    }
                                    
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .background(.yellowFFCF23.opacity(0.3))
                
                
                
                //Selected Date
                HStack{
                    Text(modelView.selectedDate.formattedString())
                }
                .padding(.top,20)
                
                
                
                
                //History ListView
                List(modelView.expenses) { expense in
                    VStack(spacing: 0){
                        Divider()
                        HStack(alignment: .center){
                            HistoryCategoryIcon(category: expense.category)
                            Spacer().frame(width: 20)
                            Text("\(expense.category.rawValue)")
                            Spacer()
                            Spacer()
                            Text("IDR\(expense.amount, specifier: "%.f")")
                                .font(.system(size: 20))
                                .foregroundColor(.red)
                                .fontWeight(.semibold)
                        }
                        .padding(.top,20)
                    }
                    .listRowSeparator(.hidden)
                    
                }
                .listStyle(PlainListStyle())
                
            }
        }
    }
}

#Preview {
    AllHistoryView()
}
