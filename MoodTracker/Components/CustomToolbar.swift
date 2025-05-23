//
//  CustomToolbar.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 23/5/25.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: @preconcurrency PreferenceKey {
    @MainActor static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

@MainActor
final class ScrollTracker: ObservableObject {
    @Published var scrollOffset: CGFloat = 0
    @Published var isCompact: Bool = false
   
     func updateOffset(_ offset: CGFloat) {
        scrollOffset = offset
        isCompact = scrollOffset < -20
    }
}

struct CustomToolbar: View {
    @Binding var selectedDate: Date
    let isCompact: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Mood Tracker")
                    .customFont(isCompact ? .body : .title, weight: .bold)
                    .frame(maxWidth: .infinity, alignment: isCompact ? .center : .leading)
                
                Spacer()
                
                if !isCompact{
                    HStack {
                        Text(selectedDate, format: .dateTime.year().month())
                            .customFont(.body)
                        
                        Image(systemName: "calendar")
                            .foregroundStyle(.accent)
                    }
                    .padding(8)
                    .background(Color.white, in: .capsule)
                }
            }
            .animation(.smooth, value: isCompact)
        }
    }
}

fileprivate struct CustomToolbarModifier<V: View>: ViewModifier {
    @ViewBuilder let toolbarContent: () -> V
    
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                   toolbarContent()
                }
            }
    }
}

extension View {
    public func customToolbar<V: View>(@ViewBuilder _ content: @escaping () -> V) -> some View {
        modifier(CustomToolbarModifier(toolbarContent: content))
    }
}
