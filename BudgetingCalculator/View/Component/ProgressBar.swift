//
//  ProgressBar.swift
//  BudgetingCalculator
//
//  Created by Michael Varian Kostaman on 12/07/24.
//

import SwiftUI

struct ProgressBar: ProgressViewStyle {
    var color: Color = .lightOrange
    var height: Double = 65.0
    var labelFontStyle: Font = .body

    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0.0

        GeometryReader { geometry in
            VStack(alignment: .leading) {
                configuration.label
                    .font(labelFontStyle)
                
                Rectangle()
                    .fill(color.opacity(0.5))
                    .frame(height: height)
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        Rectangle()
                            .fill(color)
                            .frame(width: geometry.size.width * progress)
                            .clipShape(RoundedCornersShape(radius: 20, corners: [.topRight, .bottomRight]))
                            .overlay {
                                if let currentValueLabel = configuration.currentValueLabel {
                                    currentValueLabel
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                            }
                    }
            }
        }
    }
}
