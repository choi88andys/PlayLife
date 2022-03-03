//
//  Date+localDate.swift
//  PlayLife
//
//  Created by MacAndys on 2022/01/13.
//

import Foundation


extension Date {
    func getString(withoutYear: Bool) -> String {
        let dateFormatter = DateFormatter()
        if withoutYear {
            dateFormatter.dateFormat = "M월 d일"
        } else {
            dateFormatter.dateFormat = "yyyy년 M월 d일"
        }
                        
        return dateFormatter.string(from: self)
    }
    
}
