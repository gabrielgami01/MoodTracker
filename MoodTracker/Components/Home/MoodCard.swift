//
//  MoodCard.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 13/5/25.
//

import SwiftUI

struct MoodCard: View {
    let mood: Mood
    let actualSlot: TimeSlot
    let onDelete: () -> Void
    let onEdit: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(mood.type.imageName)
                    .resizable()
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading) {
                    Text(LocalizedStringKey(mood.type.rawValue.capitalized))
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
                    
                    if Calendar.current.startOfDay(for: mood.date) == Calendar.current.startOfDay(for: .now) && mood.timeSlot == actualSlot  {
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
                HStack(spacing: 0) {
                    Text("You felt ")
                    
                    Group {
                        ForEach(mood.emotions) { emotion in
                            Text(LocalizedStringKey(emotion.rawValue.capitalized)) + Text(mood.emotions.last == emotion ? "" : ", ")
                        }
                    }
                    .bold()
                }
                
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
        MoodCard(mood: .mock1, actualSlot: .dawn) {} onEdit: {}
    }
    .padding()
    .background(Color.background)
}
