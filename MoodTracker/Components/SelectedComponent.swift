//
//  SelectedComponent.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 10/5/25.
//

import SwiftUI

struct SelectedComponent<V: RandomAccessCollection>: View where V.Element: Identifiable & Hashable {
    let values: V
    var displayKeyPath: KeyPath<V.Element, String>? = nil
    let maxElement: Int
    let onClearAll: () -> Void
    let onTap: (V.Element) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Selected (max \(maxElement))")
                    .font(.body)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    onClearAll()
                } label: {
                    Text("Clear all")
                }
            }
            
            HStack {
                ForEach(values) { value in
                    HStack {
                        if let keyPath = displayKeyPath {
                            let item = value[keyPath: keyPath]
                            Text(item)
                                .tag(item)
                        } else {
                            Text("\(value)".capitalized)
                                .tag(value)
                        }
                        
                        Button {
                            onTap(value)
                        } label: {
                            Image(systemName: "xmark")
                                .font(.footnote)
                                .padding(4)
                                .background(Color.gray.opacity(0.2), in: .circle)
                        }
                    }
                    .padding(8)
                    .background(Color.white, in: .capsule)
                    
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.background.ignoresSafeArea(edges: .all)
            
        SelectedComponent(values: [Emotions.angry, Emotions.stressed], maxElement: 3) {} onTap: { _ in }
            .padding()
    }
}
