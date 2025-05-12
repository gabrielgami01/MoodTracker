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
    @ObservedObject var vm = MoodsVM()
    
    @State private var showAddMood = false
    
    var body: some View {
        ScrollView {
            Button {
                showAddMood.toggle()
            } label: {
                Text("Add mood")
            }
            .buttonStyle(.borderedProminent)
        }
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
    HomeView()
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
