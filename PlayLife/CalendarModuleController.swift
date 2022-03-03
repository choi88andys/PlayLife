//
//  ddd.swift
//  PlayLife
//
//  Created by MacAndys on 2022/01/10.
//


import FSCalendar


extension CalendarModule: FSCalendarDataSource {
    
    
    func minimumDate(for calendar: FSCalendar) -> Date { return Date() }
    
}
