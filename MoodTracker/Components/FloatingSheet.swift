//
//  DeleteSheet.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 13/5/25.
//

import SwiftUI

struct FloatingSheet: View {
    let iconName: String
    let title: String
    let subtitle: String
    var onDelete: (() -> Void)?
    
    @Environment(\.dismiss) private var dismiss

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
                
                Text(subtitle)
                    .customFont(.footnote)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            VStack(spacing: 16) {
                if let onDelete {
                    Button {
                        onDelete()
                        dismiss()
                    } label: {
                        Text("Delete")
                            .customFont(.body, weight: .semibold)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                }
                
                Button {
                    dismiss()
                } label: {
                    Text(onDelete != nil ? "Cancel" : "Close")
                        .customFont(.body, weight: .semibold)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(onDelete != nil ? .secondary.opacity(0.5) : .accent )
                .buttonBorderShape(.capsule)
            }
                            
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
        .presentationDetents([.height(onDelete != nil ? 300 : 250)])
        .presentationCornerRadius(0)
        .presentationDragIndicator(.hidden)
        .presentationBackground(.clear)
    }
}

#Preview("DeleteSheet") {
    FloatingSheet(iconName: "trash.circle.fill",
                title: "Delete existing mood?", subtitle: "This will permanently delete your mood data.") {}
}

#Preview("WarningSheet") {
    FloatingSheet(iconName: "exclamationmark.circle.fill",
                title: "Mood already logged", subtitle: "Try editing your existing mood instead.")
}
