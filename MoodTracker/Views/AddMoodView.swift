//
//  AddMoodView.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 9/5/25.
//

import SwiftUI

struct AddMoodView: View {
    @ObservedObject var vm = AddMoodVM()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                Text("\(vm.currentPage)/4")
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
            
            if vm.currentPage == 1 {
                firstPage
                    .transition(.move(edge: .leading))
            } else if vm.currentPage == 2 {
                secondPage
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            } else if vm.currentPage == 3 {
                thirdPage
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            } else {
                fourthPage
            }
            
            Spacer()
            
            Button {
                if vm.currentPage != 4 {
                    withAnimation {
                        vm.currentPage += 1
                    }
                } else {
                    if vm.saveMood() {
                        dismiss()
                    }
                }
            } label: {
                Text(vm.currentPage != 4 ? "Continue" : "Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor, in: .capsule)
            }
            .disabled(vm.isDisabled)
            .animation(.default, value: vm.isDisabled)
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
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
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
    
    var fourthPage: some View {
        VStack(spacing: 36) {
            AddMoodHeader(title: "Any thing you want to add",
                          subtitle: "Add your notes on any thought that reflating yout mood")
            .frame(height: 100)
            
            TextEditor(text: $vm.note)
                .autocorrectionDisabled()
                .font(.body)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(height: 300)
        }
    }
}

#Preview {
    AddMoodView(vm: AddMoodVM(repository: MockRepository()))
}

struct ReasonsButton: View {
    let reason: Reason
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button {
            onSelect()
        } label: {
            Text(reason.name)
                .lineLimit(1)
                .padding(12)
                .frame(width: 110)
                .background(isSelected ? .white : .clear, in: .capsule)
                .background {
                    Capsule()
                        .stroke(Color.accent, lineWidth: 2)
                }
                
        }
        .buttonStyle(.plain)
    }
}
