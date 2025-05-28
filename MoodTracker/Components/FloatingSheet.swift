//
//  DeleteSheet.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 13/5/25.
//

import SwiftUI

struct FloatingSheet<V: View>: View {
    let iconName: String
    let title: LocalizedStringKey
    var subtitle: LocalizedStringKey?
    @ViewBuilder let content: () -> V

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 65, height: 65)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .accent)
                .overlay {
                    Circle()
                        .stroke(.white, lineWidth: 2)
                }

            VStack(spacing: 8) {
                Text(title)
                    .customFont(.title3, weight: .bold)
                
                if let subtitle {
                    Text(subtitle)
                        .customFont(.footnote)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            
            content()
                .padding(.horizontal)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .padding(.top, 48)
        }
        .shadow(color: .black.opacity(0.1), radius: 8)
        .padding(.horizontal)
        .presentationDetents([.height(300)])
        .presentationCornerRadius(0)
        .presentationDragIndicator(.hidden)
        .presentationBackground(.clear)
    }
}


#Preview("WarningSheet") {
    FloatingSheet(iconName: "exclamationmark.circle.fill", title: "Mood already logged", subtitle: "Try editing your existing mood instead.") {
        VStack(spacing: 16) {
            Button {
                
            } label: {
                Text("Close")
                    .customFont(.body, weight: .semibold)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.accent)
            .buttonBorderShape(.capsule)
        }
    }
}

#Preview("DeleteSheet") {
    FloatingSheet(iconName: "trash.circle.fill", title: "Delete existing mood?", subtitle: "This will permanently delete your mood data.")  {
        VStack(spacing: 16) {
            Button {
                
            } label: {
                Text("Delete")
                    .customFont(.body, weight: .semibold)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            
            Button {
               
            } label: {
                Text("Cancel")
                    .customFont(.body, weight: .semibold)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.secondary.opacity(0.5))
            .buttonBorderShape(.capsule)
        }
    }
}
