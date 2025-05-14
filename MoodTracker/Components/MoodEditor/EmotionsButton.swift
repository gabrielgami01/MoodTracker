//
//  EmotionsButton.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 10/5/25.
//

import SwiftUI

struct EmotionsButton: View {
    let emotion: Emotions
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button {
            onSelect()
        } label: {
            VStack {
                Image(emotion.imageName)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding()
                    .background(isSelected ? Color.white : Color.accentColor.opacity(0.1), in: .circle)
                
                Text(emotion.rawValue)
                    .font(.footnote)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    EmotionsButton(emotion: .aww, isSelected: false) {}
}
