//
//  Int+ValueExpression.swift
//  PlayLife
//
//  Created by MacAndys on 2021/12/22.
//

import Foundation

extension Int {
    
    public func getShortenToString() -> String {
        let value = self
        let thousand = 1000
        var result: String = ""
        
        switch(value) {
        case -999 ..< thousand :
            result = String(value)
            
        case thousand ..< thousand*thousand :
            result = String("\(value/thousand)k")
            
        case Int(pow(Double(thousand), Double(2))) ..< Int(pow(Double(thousand),Double(3))) :
            result = String("\(value/Int(pow(Double(thousand), Double(2))))m")
            
        case Int(pow(Double(thousand), Double(3))) ..< Int(pow(Double(thousand),Double(4))) :
            result = String("\(value/Int(pow(Double(thousand), Double(3))))t")
            
        default :
            result = "MAX"
        }
        
        return result
    }
}


extension Int {
    func getWeekday(isLongText: Bool = true) -> String {
        let value = self
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Strings.calendarLocaleIdentifier)
        
        return isLongText ? dateFormatter.weekdaySymbols[value-1] : dateFormatter.veryShortWeekdaySymbols[value-1]
    }
        
    
    func getDay() -> String {
        let value = self
        var day = ""
        day = String(value)
        
        switch value {
        case 1:
            day += Strings.stringFirstDayOfMonth
        case 2:
            day += Strings.stringSecondDayOfMonth
        case 3:
            day += Strings.stringThirdDayOfMonth
        default:
            day += Strings.stringFourthAndAfterDayOfMonth
        }
        
        return day
    }
    
}
