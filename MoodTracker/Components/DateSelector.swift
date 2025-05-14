//
//  DateSelectorView.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 14/5/25.
//

import SwiftUI

struct DateSelector: View {
    @Binding var selectedDate: Date
    
    let dates: [Date] = Date.currentWeekDates()
    
    @Namespace private var namespace

    var body: some View {
        HStack(spacing: 8) {
            ForEach(dates, id: \.self) { date in
                DayItemView(date: date, isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate), namespace: namespace)
                    .onTapGesture {
                        withAnimation {
                            selectedDate = date
                        }
                    }
            }
        }

    }
}

struct DayItemView: View {
    let date: Date
    let isSelected: Bool
    let namespace: Namespace.ID

    var body: some View {
        VStack(spacing: 4) {
            Text(date, format: .dateTime.weekday())
                .font(.caption2)
            
            Text(date, format: .dateTime.day())
                .font(.headline)
        }
        .foregroundStyle(isSelected ? .white : .primary)
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background {
            if isSelected {
                Capsule()
                    .fill(Color.accentColor)
                    .matchedGeometryEffect(id: "SELECTED_DATE", in: namespace)
            } else {
                Capsule()
                    .fill(Color.gray.opacity(0.2))
            }
        }

    }
}

#Preview {
    DateSelector(selectedDate: .constant(.now))
}
