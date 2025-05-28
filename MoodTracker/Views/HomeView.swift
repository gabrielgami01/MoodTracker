//
//  ContentView.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 8/5/25.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("firstTime") private var firstTime: Bool = true
    @EnvironmentObject private var moodStore: MoodStore
    @StateObject var vm = HomeVM()
    @ObservedObject private var scrollTracker = ScrollTracker()
    
    @State private var showAddMood = false
    @State private var showDeleteSheet = false
    @State private var showWarningSheet = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                GeometryReader { geometry in
                    Color.clear.preference(
                        key: ScrollOffsetPreferenceKey.self,
                        value: geometry.frame(in: .global).minY
                    )
                }
                .frame(height: 0)
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    Task { @MainActor in
                        scrollTracker.updateOffset(value)
                    }
                }
                
                VStack(spacing: 32) {
                    DateSelector(selectedDate: $vm.selectedDate)
                    
                    MoodsChart(moods: moodStore.moods.reversed())
                    
                    LazyVStack(spacing: 20) {
                        ForEach(moodStore.moods) { mood in
                            MoodCard(mood: mood, actualSlot: vm.actualTimeSlot) {
                                vm.selectedMood = mood
                                withAnimation {
                                    showDeleteSheet.toggle()
                                }
                            } onEdit: {
                                vm.selectedMood = mood
                                showAddMood.toggle()
                            }
                        }
                    }
                }
            }
            .customToolbar {
                CustomToolbar(selectedDate: $vm.selectedDate, isCompact: scrollTracker.isCompact)
            }
            .overlay(alignment: .bottomTrailing) {
                if vm.isToday {
                    Button {
                        if moodStore.moods.contains(where: { $0.timeSlot == vm.actualTimeSlot }) {
                            showWarningSheet.toggle()
                        } else {
                            showAddMood.toggle()
                        }
                    } label: {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.accent, in: .circle)
                    }
                    .buttonStyle(.plain)
                }
            }
            .overlay {
                if moodStore.moods.isEmpty {
                    EmptyMoodCard(selectedDate: vm.selectedDate, isFutureDate: vm.isFuture)
                }
            }
            .sheet(isPresented: $showDeleteSheet) {
                FloatingSheet(iconName: "trash.circle.fill", title: "Delete existing mood?",
                              subtitle: "This will permanently delete your mood data")  {
                    VStack(spacing: 16) {
                        Button {
                            withAnimation {
                                moodStore.deleteMood(vm.selectedMood)
                            }
                            vm.selectedMood = nil
                            showDeleteSheet.toggle()
                        } label: {
                            Text("Delete")
                                .customFont(.body, weight: .semibold)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        
                        Button {
                            showDeleteSheet.toggle()
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
            .sheet(isPresented: $showWarningSheet) {
                FloatingSheet(iconName: "exclamationmark.circle.fill", title: "Mood already logged",
                              subtitle: "Try editing your existing mood instead") {
                    VStack(spacing: 16) {
                        Button {
                            showWarningSheet.toggle()
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
            .fullScreenCover(isPresented: $showAddMood) {
                MoodEditorView(vm: MoodEditorVM(mood: vm.selectedMood))
            }
            .task {
                if firstTime {
                    await vm.preloadData()
                    firstTime = false
                }
            }
            .onChange(of: vm.selectedDate) { newDate in
                moodStore.fetchMoods(date: newDate)
            }
            .padding(.horizontal)
            .background(Color.background)
            .scrollIndicators(.hidden)
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview {
   HomeView(vm: HomeVM(repository: MockRepository()))
        .environmentObject(MoodStore(repository: MockRepository()))
}
