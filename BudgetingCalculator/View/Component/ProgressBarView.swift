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
    
    init(progress: Binding<Double>) {
            self._progress = progress
        }
    
    var body: some View {
        VStack {
            ProgressView(value: progress, total: 1.0)
                .progressViewStyle(ProgressBar(color: Color("yellowFFCF23"), height: self.height))
            //                .padding()
            
            //            Slider(value: $progress, in: 0...1)
            //                .padding()
        }
        .frame(maxHeight: self.height)
        
        //        .padding()
    }
}

//#Preview {
//    ProgressBarView()
//}
