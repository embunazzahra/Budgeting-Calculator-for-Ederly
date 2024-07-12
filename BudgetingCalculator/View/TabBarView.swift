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

    var body: some View {
        ZStack{
            TabView {
                BudgetView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "creditcard")
                    
                        Text("asdas")
                    }
                
                HistoryView(viewModel: viewModel)
                    .tabItem {
                        Label("History", systemImage: "clock") .font(.system(size: 100))
                        
                    }.padding(.bottom)
                    
            }
            
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
//                                showingNewEntrySheet = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .padding()
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
                        }
                        .padding(.bottom, geometry.safeAreaInsets.bottom + 40)
                        Spacer()
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            
        }
        .shadow(radius: 10)
        }
        
        
}



#Preview {
    TabBarView()
}
