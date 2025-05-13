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
    @EnvironmentObject private var moodsVM: MoodsVM
    @ObservedObject var vm = HomeVM()
    
    @State private var showAddMood = false
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(moodsVM.moods) { mood in
                    MoodCard(mood: mood)
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
    }
}

#Preview {
    HomeView(vm: HomeVM(repository: MockRepository()))
        .environmentObject(MoodsVM(repository: MockRepository()))
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
