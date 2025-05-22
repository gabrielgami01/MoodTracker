//
//  MoodBar.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 14/5/25.
//

import SwiftUI

struct MoodsChart: View {
    let moods: [Mood]
    
    var body: some View {
        if !moods.isEmpty {
            VStack(alignment: .leading, spacing: 24) {
                Text("Mood chart")
                    .customFont(.body, weight: .semibold)
                
                HStack(spacing: 8) {
                    ForEach(TimeSlot.allCases) { slot in
                        if let mood = moods.first(where: { $0.timeSlot == slot }) {
                            MoodBar(slot: slot, mood: mood)
                        } else {
                            MoodBar(slot: slot)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white, in: .rect(cornerRadius: 24))
        }
    }
}

struct MoodBar: View {
    let slot: TimeSlot
    var mood: Mood? = nil
    
    let fullHeight: CGFloat = 200
    let barWidth: CGFloat  = 30
    let emojiSize: CGFloat = 28
    
    @State private var animation = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: barWidth, height: fullHeight)
                
                if let mood {
                    Capsule()
                        .fill(mood.type.color.gradient)
                        .overlay(alignment: .top) {
                            Image(mood.type.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: emojiSize)
                                .scaleEffect(animation ? 1 : 0.1)
                        }
                        .frame(width: barWidth, height: animation ? fullHeight * mood.type.numericValue : 0)
                }
            }
            
            Text(slot.rawValue)
                .customFont(.caption)
        }
        .animation(.bouncy.speed(0.3), value: animation)
        .task {
            animation.toggle()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ZStack {
        Color.background.ignoresSafeArea(edges: .all)
        
        MoodsChart(moods: Mood.mocks)
            .padding()
    }
}
