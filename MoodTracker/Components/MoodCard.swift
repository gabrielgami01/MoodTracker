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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(mood.type.imageName)
                    .resizable()
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading) {
                    Text(mood.type.rawValue)
                        .font(.headline)
                    
                    Text(mood.date.formatted(.dateTime.hour().minute(.twoDigits)))
                        .font(.footnote)
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
                    
                    Button {

                    } label: {
                        Text("Edit")
                    }
                }
                .font(.footnote)
            }
            
            VStack(alignment: .leading) {
                Text("You felt ") + Text(mood.emotionsList).bold()
                
                Text("Because of ") + Text(mood.reason.name).bold()
            }
            
            Group {
                Text("Note: ").fontWeight(.semibold) + Text(mood.note)
            }
            .font(.callout)
        }
        .padding()
        .background(Color.white, in: .rect(cornerRadius: 24))
    }
}

#Preview {
    ScrollView {
        MoodCard(mood: .mock1) {}
    }
    .padding()
    .background(Color.background)
}
