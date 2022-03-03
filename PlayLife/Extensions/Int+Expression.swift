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
    func getWeekdayAsKorean(longText: Bool = true) -> String {
        let value = self
        var weekday: String = ""
        
        switch value {
        case 1:
            weekday = "일"
        case 2:
            weekday = "월"
        case 3:
            weekday = "화"
        case 4:
            weekday = "수"
        case 5:
            weekday = "목"
        case 6:
            weekday = "금"
        case 7:
            weekday = "토"
        default:
            weekday = "일"
        }
        
        if longText {
            weekday += "요일"
        }
        return weekday
    }
    
    func getDayAsKorean() -> String {
        let value = self
        var day: String = ""
        
        day = String(value)
        day += "일"
        
        return day
    }
    
}
