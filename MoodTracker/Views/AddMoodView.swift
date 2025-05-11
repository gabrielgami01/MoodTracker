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
            } else if currentPage == 3 {
                thirdPage
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
            
            MoodSelector(selectedMood: vm.selectedMood) { mood in
                vm.selectedMood = mood
            }
        }
    }
    
    var secondPage: some View {
        VStack(spacing: 36) {
            Group {
                if vm.selectedEmotions.isEmpty {
                    AddMoodHeader(title: "Choose the emotions that make you feel \(vm.selectedMood.rawValue.lowercased())",
                                  subtitle: "Select at least 1 emotion")
                } else {
                    SelectedComponent(values: vm.selectedEmotions, maxElement: 3) {
                        vm.selectedEmotions.removeAll()
                    } onTap: { emotion in
                        vm.selectedEmotions.removeAll { $0 == emotion}
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
                        EmotionsButton(emotion: emotion, isSelected: vm.selectedEmotions.contains(emotion)) {
                            vm.selectEmotion(emotion)
                        }
                    }
                }
            }
        }
        .animation(.default, value: vm.selectedEmotions)
    }
    
    var thirdPage: some View {
        VStack(spacing: 36) {
            Group {
                if vm.selectedReason.isEmpty {
                    AddMoodHeader(title: "What`s reason making you feel this way",
                                  subtitle: "Select the reason that reflated your emotions")
                } else {
                    SelectedComponent(values: vm.selectedReason, displayKeyPath: \.name, maxElement: 1) {
                        vm.selectedReason.removeAll()
                    } onTap: { emotion in
                        vm.selectedReason.removeAll()
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
                    ForEach(vm.reasons) { reason in
                        ReasonsButton(reason: reason, isSelected: vm.selectedReason.contains(reason)) {
                            vm.selectReason(reason)
                        }
                    }
                }
            }
        }
        .animation(.default, value: vm.reasons)
    }
}

#Preview {
    AddMoodView(vm: AddMoodVM(repository: MockRepository()))
}
