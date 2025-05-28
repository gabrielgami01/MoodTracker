//
//  AddMoodHeader.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 9/5/25.
//

import SwiftUI

struct AddMoodHeader: View {
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey
    
    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .customFont(.title)
                .bold()
                .multilineTextAlignment(.center)
            
            Text(subtitle)
                .customFont(.body)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    AddMoodHeader(title: "What's your mood now?",
                  subtitle: "Select mood that reflects the most how you are feeling at this moment")
}
