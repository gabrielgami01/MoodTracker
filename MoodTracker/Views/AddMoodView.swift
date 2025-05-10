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
                    HStack {
                        Text(Date.now.formatted(.dateTime.month(.abbreviated).weekday().day()))
                        
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
            
            if currentPage == 1 {
                firstPage
                    .transition(.move(edge: .leading))
            } else if currentPage == 2 {
                secondPage
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
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
    
    var secondPage: some View {
        VStack(spacing: 36) {
            Group {
                if vm.emotions.isEmpty {
                    AddMoodHeader(title: "Choose the emotions that make you feel \(vm.mood.rawValue.lowercased())",
                                  subtitle: "Select at least 1 emotion")
                } else {
                    SelectedComponent(values: vm.emotions, maxElement: 3) {
                        vm.emotions.removeAll()
                    } onTap: { emotion in
                        vm.emotions.removeAll { $0 == emotion}
                    }
                }
            }
            .frame(height: 100)
            .transition(.opacity)
            
            VStack(alignment: .leading) {
                Text("All emotions")
                    .font(.body)
                    .fontWeight(.semibold)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(Emotions.allCases) { emotion in
                        EmotionsButton(emotion: emotion, isSelected: vm.emotions.contains(emotion)) {
                            vm.selectEmotion(emotion)
                        }
                    }
                }
            }
        }
        .animation(.default, value: vm.emotions)
    }
}

#Preview {
    AddMoodView()
}
