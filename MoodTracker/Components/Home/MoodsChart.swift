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
                    .font(.headline)
                
                HStack(spacing: 24) {
                    ForEach(moods) { mood in
                        MoodBar(mood: mood)
                            .frame(maxWidth: .infinity)
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
    let mood: Mood
    
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
            
            Text(mood.date, format: .dateTime.hour().minute())
                .font(.footnote)
        }
        .animation(.bouncy.speed(0.3), value: animation)
        .task {
            animation.toggle()
        }
    }
}

#Preview {
    ZStack {
        Color.background.ignoresSafeArea(edges: .all)
        
        MoodsChart(moods: Mood.mocks)
            .padding()
    }
}
