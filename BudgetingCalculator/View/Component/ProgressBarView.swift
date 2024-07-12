//
//  ProgressBarView.swift
//  BudgetingCalculator
//
//  Created by Michael Varian Kostaman on 12/07/24.
//

import SwiftUI

struct ProgressBarView: View {
    @State private var progress: Double = 0.5

    var body: some View {
        VStack {
            ProgressView(value: progress, total: 1.0)
                .progressViewStyle(ProgressBar(color: .brightOrange, height: 65))
                .padding()

            Slider(value: $progress, in: 0...1)
                .padding()
        }
        .padding()
    }
}

#Preview {
    ProgressBarView()
}
