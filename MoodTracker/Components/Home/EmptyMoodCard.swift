//
//  EmptyMoodCard.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 14/5/25.
//

import SwiftUI

struct EmptyMoodCard: View {
    let selectedDate: Date
    let isFutureDate: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            Image("grinning_face")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .foregroundStyle(.secondary)
            
            VStack(spacing: 4) {
                Text(isFutureDate ? "Future Date" : "No Mood Logged")
                    .customFont(.title, weight: .bold)
                
                Text(isFutureDate ? "You can’t register a mood for future dates." : "You haven’t logged any mood for this day.")
                    .customFont(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    EmptyMoodCard(selectedDate: .now, isFutureDate: false)
}
