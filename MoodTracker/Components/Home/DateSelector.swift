//
//  DateSelectorView.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 14/5/25.
//

import SwiftUI

struct DateSelector: View {
    @Binding var selectedDate: Date

    @State private var referenceDate: Date = .now
    @Namespace private var namespace

    private let calendar = Calendar(identifier: .iso8601)
    private var weekDates: [Date] {
        Date.weekDates(containing: referenceDate)
    }
    private var isCurrentWeek: Bool {
        calendar.isDate(referenceDate, equalTo: .now, toGranularity: .weekOfYear)
    }

    var body: some View {
        HStack {
            Button {
                withAnimation {
                    referenceDate = calendar.date(byAdding: .weekOfYear, value: -1, to: referenceDate) ?? referenceDate
                    if !calendar.isDate(selectedDate, equalTo: referenceDate, toGranularity: .weekOfYear) {
                        selectedDate = referenceDate
                    }
                }
            } label: {
                Image(systemName: "chevron.left.circle.fill")
                    .font(.title2)
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                ForEach(weekDates, id: \.self) { date in
                    DayItemView(date: date, isSelected: calendar.isDate(date, inSameDayAs: selectedDate), namespace: namespace) {
                        withAnimation(.easeInOut) {
                            selectedDate = date
                            referenceDate = date
                        }
                    }
                }
            }
            
            Spacer()

            Button {
                withAnimation {
                    referenceDate = calendar.date(byAdding: .weekOfYear, value: 1, to: referenceDate) ?? referenceDate
                    if !calendar.isDate(selectedDate,equalTo: referenceDate, toGranularity: .weekOfYear) {
                        if isCurrentWeek{
                            selectedDate = .now
                        } else {
                            selectedDate = referenceDate
                        }
                    }
                }
            } label: {
                Image(systemName: "chevron.right.circle.fill")
                    .font(.title2)
            }
            .disabled(isCurrentWeek)
        }
        .frame(maxWidth: .infinity)
    }
}

struct DayItemView: View {
    let date: Date
    let isSelected: Bool
    let namespace: Namespace.ID
    let onTap: () -> Void

    var body: some View {
        VStack(spacing: 4) {
            Text(date, format: .dateTime.weekday(.narrow))
                .customFont(.caption2)
            
            Text(date, format: .dateTime.day(.twoDigits))
                .customFont(.body, weight: .semibold)
        }
        .foregroundStyle(isSelected ? .white : .primary)
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background {
            if isSelected {
                Capsule()
                    .fill(Color.accentColor)
                    .matchedGeometryEffect(id: "SELECTED_DATE", in: namespace)
            } else {
                Capsule()
                    .fill(Color.white)
            }
        }
        .frame(width: 40)
        .onTapGesture {
            onTap()
        }

    }
}

#Preview {
    ZStack {
        Color.background.ignoresSafeArea(edges: .all)
        
        DateSelector(selectedDate: .constant(.now))
            .padding()
    }
}
