//
//  Font.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 22/5/25.
//

import SwiftUI

struct CustomFont: ViewModifier {
    let font: Font
    let weight: Font.Weight
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .fontWeight(weight)
            .fontDesign(.serif)
    }
}

extension View {
    func customFont(_ font: Font, weight: Font.Weight = .regular) -> some View {
        modifier(CustomFont(font: font, weight: weight))
    }
}

