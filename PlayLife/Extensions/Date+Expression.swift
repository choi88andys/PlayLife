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
            dateFormatter.dateFormat = Strings.dateFormatWithoutYear
        } else {
            dateFormatter.dateFormat = Strings.dateFormatWithYear
        }
                        
        return dateFormatter.string(from: self)
    }
    
}

