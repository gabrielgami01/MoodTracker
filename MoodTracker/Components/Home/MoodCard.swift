//
//  MoodCard.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 13/5/25.
//

import SwiftUI

struct MoodCard: View {
    let mood: Mood
    let onDelete: () -> Void
    let onEdit: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(mood.type.imageName)
                    .resizable()
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading) {
                    Text(mood.type.rawValue)
                        .customFont(.body, weight: .semibold)
                    
                    Text(mood.date, format: .dateTime.hour().minute(.twoDigits))
                        .customFont(.footnote)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                HStack(spacing: 20) {
                    Button {
                        onDelete()
                    } label: {
                        Text("Delete")
                    }
                    .foregroundStyle(.red)
                    
                    if Calendar.current.startOfDay(for: mood.date) == Calendar.current.startOfDay(for: .now) {
                        Button {
                            onEdit()
                        } label: {
                            Text("Edit")
                        }
                    }
                }
                .customFont(.footnote)
            }
            
            VStack(alignment: .leading) {
                Text("You felt ") + Text(mood.emotionsList).bold()
                
                Text("Because of ") + Text(mood.reason.name).bold()
            }
            .customFont(.body)
            
            Group {
                Text("Note: ").fontWeight(.semibold) + Text(mood.note)
            }
            .customFont(.callout)
        }
        .padding()
        .background(Color.white, in: .rect(cornerRadius: 24))
    }
}

#Preview {
    ScrollView {
        MoodCard(mood: .mock1) {} onEdit: {}
    }
    .padding()
    .background(Color.background)
}
