//
//  ProgressBarView.swift
//  BudgetingCalculator
//
//  Created by Michael Varian Kostaman on 12/07/24.
//

import SwiftUI

struct ProgressBarView: View {
    @Binding var progress: Double
    private var height = 65.0
    var color: Color
    
    init(progress: Binding<Double>,color: Color = Color("yellowFFCF23")) {
        self._progress = progress
        self.color = color
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress, total: 1.0)
                .progressViewStyle(ProgressBar(color: color, height: self.height))
        }
        .frame(maxHeight: self.height)
        
    }
}

//#Preview {
//    ProgressBarView()
//}
