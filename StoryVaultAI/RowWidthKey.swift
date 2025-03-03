//
//  RowWidthKey.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

struct RowWidthKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        let next = nextValue()
        if next > value { value = next }
    }
}
