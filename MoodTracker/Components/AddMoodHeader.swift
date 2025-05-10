//
//  AddMoodHeader.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 9/5/25.
//

import SwiftUI

struct AddMoodHeader: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            
            Text(subtitle)
                .font(.body)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    AddMoodHeader(title: "What's your mood now?",
                  subtitle: "Select mood that reflects the most how you are feeling at this moment")
}
