//
//  MoodBar.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 14/5/25.
//

import SwiftUI

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
                
                VStack(spacing: 0) {
                    Image(mood.type.imageName)
                        .resizable()
                        .frame(width: 28, height: 28)
                    
                    Capsule()
                        .fill(mood.type.color.gradient)
                        .frame(width: barWidth, height: animation ? fullHeight * mood.type.numericValue : 0)
                }
                
            }
            
            Text(mood.date.formatted(.dateTime.hour().minute()))
                .font(.footnote)
        }
        .animation(.bouncy.speed(0.5), value: animation)
        .task {
            animation.toggle()
        }
    }
}

#Preview {
    MoodBar(mood: .mock1)
}
