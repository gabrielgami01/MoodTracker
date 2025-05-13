//
//  MoodTrackerApp.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 8/5/25.
//

import SwiftUI

@main
struct MoodTrackerApp: App {
    @StateObject var moodsVM = MoodStore()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(moodsVM)
        }
    }
}
