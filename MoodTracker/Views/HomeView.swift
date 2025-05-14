//
//  ContentView.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 8/5/25.
//

import SwiftUI
import Charts

struct HomeView: View {
    @AppStorage("firstTime") private var firstTime: Bool = true
    @EnvironmentObject private var moodStore: MoodStore
    @ObservedObject var vm = HomeVM()
    
    @State private var showAddMood = false
    @State private var showDeleteSheet = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                DateSelector(selectedDate: $vm.date)
                
                MoodsChart(moods: moodStore.moods)
                
                LazyVStack(spacing: 20) {
                    ForEach(moodStore.moods) { mood in
                        MoodCard(mood: mood) {
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
        .overlay(alignment: .bottomTrailing) {
            Button {
                showAddMood.toggle()
            } label: {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.accent, in: .circle)
            }
            .buttonStyle(.plain)
        }
        .sheet(isPresented: $showDeleteSheet) {
            DeleteSheet(isPresented: $showDeleteSheet, iconName: "trash.circle.fill",
                        title: "Delete existing mood?", subtitle: "This will permanently delete your mood data.") {
                withAnimation {
                    moodStore.deleteMood(vm.selectedMood)
                }
                vm.selectedMood = nil
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
        .onChange(of: vm.date) { newValue in
            moodStore.fetchMoods(date: newValue)
        }
        .padding(.horizontal)
        .background(Color.background)
        .scrollIndicators(.hidden)
    }
}

#Preview {
   HomeView(vm: HomeVM(repository: MockRepository()))
        .environmentObject(MoodStore(repository: MockRepository()))
}



