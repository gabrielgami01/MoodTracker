//
//  AddMoodView.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 9/5/25.
//

import SwiftUI

struct AddMoodView: View {
    @ObservedObject var vm = AddMoodVM()
    
    @State private var currentPage = 1
    
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                Text("\(currentPage)/4")
                    .font(.headline)

                HStack {
                    if currentPage == 1 {
                        HStack {
                            Text(Date.now.formatted(.dateTime.month(.abbreviated).weekday().day()))
                            
                            Image(systemName: "calendar")
                                .foregroundStyle(.accent)
                        }
                        .padding(8)
                        .background(Color.white, in: .capsule)
                    } else {
                        Button {
                            withAnimation {
                                currentPage -= 1
                            }
                        } label: {
                            Image(systemName: "arrow.backward")
                                .font(.title2)
                        }
                        .buttonStyle(.plain)
                    }

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
            
            if currentPage == 1 {
                firstPage
                    .transition(.move(edge: .leading))
            }
            
            Spacer()
            
            Button {
                withAnimation {
                    currentPage += 1
                }
            } label: {
                Text("Continue")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor, in: .capsule)
            }
        }
        .padding(.horizontal)
        .background(Color.background)
    }
    
    var firstPage: some View {
        VStack(spacing: 200) {
            AddMoodHeader(title: "What's your mood now?",
                          subtitle: "Select mood that reflects the most how you are feeling at this moment")
            
            MoodSelector(selectedMood: vm.mood) { mood in
                vm.mood = mood
            }
        }
    }
}

#Preview {
    AddMoodView()
}
