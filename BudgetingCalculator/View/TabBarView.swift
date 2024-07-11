//
//  TabBarView.swift
//  Calculator
//
//  Created by Kevin Fairuz on 10/07/24.
//

import SwiftUI

struct TabBarView: View {
    @StateObject var viewModel: BudgetViewModel = BudgetViewModel(dataSource: .shared)

    var body: some View {
        TabView {
            BudgetView(viewModel: viewModel)
                .tabItem {
                    Label("Dashboard", systemImage: "creditcard")
                }
            HistoryView(viewModel: viewModel)
                .tabItem {
                    Label("History", systemImage: "clock")
                }
            BudgetSettingsView(viewModel: viewModel)
                .tabItem {
                    Label("Budget", systemImage: "dollarsign.circle.fill")
                }
        }
        
    }
        
}


#Preview {
    TabBarView()
}
