//
//  MoodSelector.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 9/5/25.
//

import SwiftUI

struct MoodSelector: View {
    let selectedMood: MoodTypes
    let onTap: (MoodTypes) -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            HStack(spacing: 24) {
                ForEach(MoodTypes.allCases) { mood in
                    Button {
                      onTap(mood)
                    } label: {
                        Image(mood.imageName)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .scaleEffect(selectedMood == mood ? 2 : 1)
                    }
                }
            }
            
            
            Group {
                Text("You're feeling ") + Text(LocalizedStringKey(selectedMood.rawValue))
            }
            .customFont(.body, weight: .semibold)
        }
        .animation(.default, value: selectedMood)
    }
}

#Preview {
    MoodSelector(selectedMood: .neutral) { _ in }
}
