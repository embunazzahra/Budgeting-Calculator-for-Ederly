//
//  OffsetKey.swift
//  BudgetingCalculator
//
//  Created by Dhau Embun Azzahra on 15/07/24.
//

import SwiftUI

struct OffsetKey: PreferenceKey{
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue() 
    }
}
