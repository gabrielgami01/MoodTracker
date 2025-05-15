//
//  MoodEditorHeader.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 14/5/25.
//

import SwiftUI

struct MoodEditorHeader: View {
    @Binding var currentPage: Int
    let dismiss: () -> Void
    
    var body: some View {
        ZStack {
            Text("\(currentPage)/4")
                .font(.headline)
            
            HStack {
                HStack {
                    Text(Date.now, format: .dateTime.month(.abbreviated).weekday().day())
                        .font(.body)
                    
                    Image(systemName: "calendar")
                        .foregroundStyle(.accent)
                }
                .padding(8)
                .background(Color.white, in: .capsule)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(Color.white, in: .circle)
                }
                .buttonStyle(.plain)
            }
        }
        .frame(height: 40)
    }
}

#Preview {
    ScrollView {
        MoodEditorHeader(currentPage: .constant(1)) { }
            .padding()
    }
    .background(Color.background)
}
