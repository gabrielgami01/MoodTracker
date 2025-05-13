//
//  DeleteSheet.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 13/5/25.
//

import SwiftUI

struct DeleteSheet: View {
    @Binding var isPresented: Bool
    let iconName: String
    let title: String
    let subtitle: String
    let onDelete: () -> Void

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
                    .font(.title3)
                    .bold()
                
                Text(subtitle)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            VStack(spacing: 16) {
                Button {
                    onDelete()
                    isPresented.toggle()
                } label: {
                    Text("Delete")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                
                Button {
                    isPresented.toggle()
                } label: {
                    Text("Cancel")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.secondary.opacity(0.5))
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
        .presentationDetents([.height(300)])
        .presentationCornerRadius(0)
        .presentationDragIndicator(.hidden)
        .presentationBackground(.clear)
    }
}

#Preview {
    DeleteSheet(isPresented: .constant(true), iconName: "trash.circle.fill",
                title: "Delete existing mood?", subtitle: "This will permanently delete your mood data.") {}
}
