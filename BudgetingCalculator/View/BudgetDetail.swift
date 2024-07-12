//
//  BudgetDetail.swift
//  BudgetingCalculator
//
//  Created by Kevin Fairuz on 11/07/24.
//

import SwiftUI

struct BudgetDetail : View {
    @ObservedObject var viewModel: BudgetViewModel
    let category: ExpenseCategory

    var body: some View {
        VStack {
            Text("Set Budget for \(category.rawValue)")
                .font(.headline)
            // Tambahkan elemen UI untuk input dan pengaturan anggaran
        }
        .padding()
        .navigationTitle(category.rawValue)
    }
}

#Preview {
    BudgetDetail(viewModel: BudgetViewModel(dataSource: .shared), category: .household)
}