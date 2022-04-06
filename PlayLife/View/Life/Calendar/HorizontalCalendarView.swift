//
//  SingleCalendarView.swift
//  PlayLife
//
//  Created by MacAndys on 2022/01/22.
//

import SwiftUI
struct HorizontalCalendarView: View {
    @Binding var currentDate: Date
    @Binding var selectedDate: Date?
    @Binding var scrollTodayToggle: Bool
    @Binding var swipeDirection: UnitPoint?
        
    @State var showingDate: Date?
    @State var prevDate: Date?
    
    func getDates(currentDate: Date) -> [Date] {
        var startDate = Calendar.current.date(byAdding: .day, value: SettingConstants.startDateLimit * -1, to: currentDate)!
        let endDate = Calendar.current.date(byAdding: .day, value: SettingConstants.endDateLimit, to: currentDate)!
        
        var dates: [Date] = []
        while startDate <= endDate {
            dates.append(startDate)
            startDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
        }
        return dates
    }
    
    
    var body: some View {
        let dates = getDates(currentDate: currentDate)
        let cellHeight: CGFloat = SettingConstants.fontSize*3
        let cellWidth: CGFloat = SettingConstants.fontSize*3
        
        
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { value in
                LazyHStack(spacing: SettingConstants.fontSize*0.8) {
                    ForEach(dates, id: \.self) { day in
                        Group {
                            if selectedDate == day {
                                Circle()
                                    .fill(Color.systemGray4)
                                    .overlay(DayCellView(currentDate: $currentDate, day: day))
                                    .onAppear {
                                        showingDate = day                                        
                                    }
                                    .onDisappear {
                                        prevDate = day
                                        if (swipeDirection != nil) && (showingDate == prevDate) {
                                            withAnimation {
                                                value.scrollTo(selectedDate, anchor: swipeDirection)
                                            }
                                        }
                                        swipeDirection = nil
                                    }
                            }
                            else {
                                DayCellView(currentDate: $currentDate, day: day)
                                    .onTapGesture {
                                        selectedDate = day
                                    }
                            }
                        }
                        .id(day)
                    }
                    .frame(width: cellWidth, height: cellHeight)
                }
                .frame(height: cellHeight)
                .onAppear {
                    value.scrollTo(selectedDate!, anchor: .center)
                }
                .onChange(of: scrollTodayToggle) { _ in
                    withAnimation {
                        value.scrollTo(currentDate, anchor: .center)
                    }
                }
            }
        }
    }
    
    
    struct DayCellView: View {
        @Binding var currentDate: Date
        var day: Date
            
        func getWeekday(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: Strings.calendarLocaleIdentifier)
            dateFormatter.dateFormat = "E"
            return dateFormatter.string(from: date)
        }
        func getDay(date: Date) -> Int {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: date)
            return components.day ?? 0
        }
        
        var body: some View {
            return VStack(spacing: SettingConstants.fontSize*0.6) {
                Text(getWeekday(date: day))
                    .font(.system(
                        size: SettingConstants.fontSize*0.7,
                        weight: day==currentDate ? Font.Weight.black : Font.Weight.light))
                Text("\(getDay(date: day))")
                    .font(.system(
                        size: SettingConstants.fontSize*1.0,
                        weight: day==currentDate ? Font.Weight.heavy : Font.Weight.regular))
            }
        }
    }
}



