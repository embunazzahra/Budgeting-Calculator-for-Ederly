//
//  TabBarView.swift
//  Calculator
//
//  Created by Kevin Fairuz on 10/07/24.
//

import SwiftUI

struct TabBarView: View {
    @StateObject var viewModel: BudgetViewModel = BudgetViewModel(dataSource: .shared)
    @State private var selectedTab = 0
    @State var isPresentCategoryExpense = false
    


    var body: some View {
        NavigationStack{
            ZStack{
                TabView { 
                    Group {
                        BudgetView(viewModel: viewModel)
                            .tabItem {
                                Image(systemName: "creditcard")
                                
                                Text("Dashboard")
                            }
                        BudgetSettingsView(viewModel: viewModel)
                            .tabItem {
                                Label("Budget", systemImage: "dollarsign.circle.fill") .font(.system(size: 100))
                                
                            }
                    }
                    
                    .toolbarBackground(.tapBar, for: .tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
                    
                }
                .accentColor(.orangeColour)
                .shadow(color: .black.opacity(1), radius: 0, x: 50, y: 50)
                
                
                ExpenseButton(viewModel: viewModel)
            }
        }
        }
        
        
}



#Preview {
    TabBarView()
}
