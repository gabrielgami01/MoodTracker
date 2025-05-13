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
            LazyVStack(spacing: 20) {
                ForEach(moodStore.moods) { mood in
                    MoodCard(mood: mood) {
                        vm.selectedMood = mood
                        withAnimation {
                            showDeleteSheet.toggle()
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
        .padding(.horizontal)
        .sheet(isPresented: $showDeleteSheet) {
            DeleteSheet(isPresented: $showDeleteSheet, iconName: "trash.circle.fill",
                        title: "Delete existing mood?", subtitle: "This will permanently delete your mood data.") {
                withAnimation {
                    moodStore.deleteMood(vm.selectedMood)
                }
            }
        }
        .background(Color.background)
        .scrollIndicators(.hidden)
        .fullScreenCover(isPresented: $showAddMood) {
            AddMoodView()
        }
        .task {
            if firstTime {
                await vm.preloadData()
                firstTime = false
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
   HomeView(vm: HomeVM(repository: MockRepository()))
        .environmentObject(MoodStore(repository: MockRepository()))
}

struct DayCard: View {
    var body: some View {
        VStack {
            Text(Date().formatted(.dateTime.weekday()))
                .font(.body)
            
            Text(Date().formatted(.dateTime.day(.defaultDigits)))
                .font(.title3)
                .bold()
        }
        .foregroundStyle(.white)
        .padding()
        .background(Color.accent, in: .capsule)
    }
}
