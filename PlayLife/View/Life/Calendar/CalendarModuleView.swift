//
//  CalendarModuleView.swift
//  PlayLife
//
//  Created by MacAndys on 2022/01/08.
//


import SwiftUI
import FSCalendar

struct CalendarModuleView: UIViewRepresentable {
    var prevDate: Date? = nil
    @Binding var selectedDate: Date?
    
    
    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        
        
        calendar.headerHeight = SettingConstants.fontSize*4
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.appearance.headerDateFormat = SettingConstants.calendarHeaderDateFormat
        calendar.appearance.headerTitleColor = UIColor.label
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: SettingConstants.fontSize*1.8)
        
        
        calendar.placeholderType = FSCalendarPlaceholderType.none
        calendar.select(selectedDate)
        calendar.today = nil
        calendar.appearance.selectionColor = UIColor(Color.skyBlue)
        
        
        calendar.appearance.weekdayTextColor = UIColor.label
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: SettingConstants.fontSize*0.9)
        
        
        calendar.appearance.titleDefaultColor = UIColor.label
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: SettingConstants.fontSize*0.85)
        calendar.appearance.titleSelectionColor = UIColor.systemBackground
        
        
        if prevDate != nil {
            let point: CGPoint = CGPoint(x: 0, y: SettingConstants.fontSize * -0.5)
            calendar.appearance.eventOffset = point
            calendar.appearance.eventDefaultColor = UIColor.gray
        }
        
        
        calendar.locale = Locale(identifier: SettingConstants.calendarLocaleIdentifier)
        return calendar
    }
    
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.select(selectedDate)
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        var parent: CalendarModuleView
        
        init(_ calender: CalendarModuleView) {
            parent = calender
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
        }
        
        func minimumDate(for calendar: FSCalendar) -> Date {
            return Date()
        }
        
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            guard let prevDate = parent.prevDate else {
                return 0
            }
            
            if Calendar.current.startOfDay(for: date) == Calendar.current.startOfDay(for: prevDate) {
                return 1
            }
            else {
                return 0
            }
        }
    }
}


