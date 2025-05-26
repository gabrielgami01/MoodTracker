//
//  AddMoodView.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 9/5/25.
//

import SwiftUI

struct MoodEditorView: View {
    @EnvironmentObject private var moodStore: MoodStore
    @StateObject var vm: MoodEditorVM
    
    @State private var showAddReason = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
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
                }
            }
            .customToolbar {
                MoodEditorHeader(currentPage: $vm.currentPage) {
                    dismiss()
                }
            }
            .safeAreaInset(edge: .bottom, spacing: 16) {
                Button {
                    if vm.currentPage != 4 {
                        withAnimation {
                            vm.currentPage += 1
                        }
                    } else {
                        if let newMood = vm.createMood() {
                            if vm.mood == nil {
                                moodStore.addMood(newMood)
                            } else {
                                moodStore.updateMood(newMood)
                            }
                            dismiss()
                        }
                    }
                } label: {
                    Text(vm.currentPage != 4 ? "Continue" : "Save")
                        .customFont(.body, weight: .semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor, in: .capsule)
                }
                .disabled(vm.isDisabled)
                .animation(.default, value: vm.isDisabled)
            }
            .sheet(isPresented: $showAddReason) {
                FloatingSheet(iconName: "plus.circle.fill", title: "Add new reason") {
                    VStack(spacing: 24) {
                        TextField("Reason", text: $vm.newReason)
                            .customFont(.body)
                            .autocorrectionDisabled()
                            .textFieldStyle(.roundedBorder)
                            .clipShape(.rect(cornerRadius: 12))
                        
                        VStack(spacing: 16){
                            Button {
                                moodStore.addReason(vm.createReason())
                                showAddReason.toggle()
                            } label: {
                                Text("Save")
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
            }
            .padding(.horizontal)
            .padding(.top, 8)
            .background(Color.background)
            .scrollBounceBehavior(.basedOnSize)
            .task {
                moodStore.fetchReasons()
            }
        }
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
                    .customFont(.body, weight: .semibold)
                
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
                HStack {
                    Text("All reasons")
                        .customFont(.body, weight: .semibold)
                    
                    Spacer()
                    
                    Button {
                        showAddReason.toggle()
                    } label: {
                        Text("Add new reason")
                            .customFont(.body)
                    }
                }
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(moodStore.reasons) { reason in
                        ReasonsButton(reason: reason, isSelected: vm.selectedReason.contains(reason)) {
                            vm.selectReason(reason)
                        }
                    }
                }
            }
        }
        .animation(.default, value: moodStore.reasons)
    }
    
    var fourthPage: some View {
        VStack(spacing: 36) {
            AddMoodHeader(title: "Any thing you want to add",
                          subtitle: "Add your notes on any thought that reflating yout mood")
            .frame(height: 100)
            
            TextEditor(text: $vm.note)
                .autocorrectionDisabled()
                .scrollDisabled(true)
                .customFont(.body)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(height: 250)
        }
    }
}

#Preview {
    MoodEditorView(vm: MoodEditorVM(repository: MockRepository()))
        .environmentObject(MoodStore(repository: MockRepository()))
}
