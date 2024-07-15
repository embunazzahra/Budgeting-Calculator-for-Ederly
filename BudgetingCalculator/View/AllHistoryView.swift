//
//  AllHistoryView.swift
//  BudgetingCalculator
//
//  Created by Dhau Embun Azzahra on 15/07/24.
//

import SwiftUI

struct AllHistoryView: View {
    @StateObject var modelView: AllHistoryViewModel
    @Namespace private var animation
    
    init() {
        _modelView = StateObject(wrappedValue: AllHistoryViewModel(dataSource: .shared))
    }
    
    var body: some View {
        NavigationView {
            VStack{
                
                //Week SLider
                TabView(selection: $modelView.currentWeekIndex){
                    
                    ForEach(modelView.weekSlider.indices, id: \.self){ index in
                        let week = modelView.weekSlider[index]
                        weekView(week).tag(index)
                        
                    }
                    
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 90)
                .background(.yellowFFCF23.opacity(0.3))
            
                
                //Selected Date
                HStack{
                    Text(modelView.selectedDate.formattedString())
                }
                .padding(.top,20)
                
                
                historyListView() 
            }
            .onChange(of: modelView.currentWeekIndex, perform: { newValue in
                                modelView.handleWeekIndexChange(oldValue: modelView.currentWeekIndex, newValue: newValue)
                            })
        }
    }
    
    func weekView(_ week: [WeekDay]) -> some View{
        HStack(spacing:10){
            ForEach(week){ day in
                VStack(spacing: 10){
                    
                    Text(day.date.format("EEE").prefix(1))
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                    
                    ZStack{
                        Circle()
                            .fill(.yellowFFCF23)
                            .frame(width: 26,height: 26)
                            .opacity(modelView.isToday(date: day.date) ? 1 : 0)
                            
                        
                        Text(day.date.format("dd"))
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
                        modelView.selectedDate = day.date
                    }
                }
                
            }
        }
//        .padding(.horizontal)
        .background{
            GeometryReader {
                let minX = $0.frame(in: .global).minX
                
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self) {
                        value in
                        if value.rounded() == 10 && modelView.createWeek{
                            modelView.paginateWeek()
                            modelView.createWeek = false
                        }
                    }
            }
        }
    }
    
    func historyListView() -> some View{
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

#Preview {
    AllHistoryView()
}
