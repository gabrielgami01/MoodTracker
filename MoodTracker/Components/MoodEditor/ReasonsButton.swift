//
//  ReasonsButton.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 11/5/25.
//

import SwiftUI

struct ReasonsButton: View {
    let reason: Reason
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button {
            onSelect()
        } label: {
            Text(reason.name)
                .customFont(.body)
                .lineLimit(1)
                .padding(12)
                .frame(width: 110)
                .background(isSelected ? .white : .clear, in: .capsule)
                .background {
                    Capsule()
                        .stroke(Color.accent, lineWidth: 2)
                }
                
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ReasonsButton(reason: .mock1, isSelected: false) {}
}
