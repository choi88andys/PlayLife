//
//  Item+CoreDataProperties.swift
//  PlayLife
//
//  Created by MacAndys on 2021/12/24.
//
//

import Foundation
import CoreData


enum ItemType: Int16, CaseIterable{
    case once = 1
    case daysOfWeek = 7
    case daysOfMonth = 31
}


extension Item {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }
    
    @NSManaged public var registerDate: Date?
    @NSManaged public var itemType: Int16
    @NSManaged public var content: String?
    @NSManaged public var selectedDate: Date?
    @NSManaged public var isSun: Bool
    @NSManaged public var isMoon: Bool
    @NSManaged public var selectedDays: [Int]?
    @NSManaged public var isDoneArray: [Date]

    
    var typeSelection: ItemType {
        get {
            return ItemType(rawValue: itemType)!
        }
        set {
            itemType = newValue.rawValue
        }
    }
    
    
    public var wrappedRegisterDate: Date {
        registerDate ?? Date()
    }
    
    public var wrappedSelectedDays: [Int] {
        selectedDays ?? [Int]()
    }
    
    public var wrappedContent: String {
        content ?? ""
    }
    
    public var wrappedSelectedDate: Date {
        selectedDate ?? Date()
    }
    
    
    func addData(registerDate: Date,
                 isDoneArray: [Date] = [Date](),
                 content: String, isSun: Bool, isMoon: Bool, typeSelection: ItemType,
                 selectedDaysInMonth: [Int], selectedDaysInWeek: [Int], selectedDate: Date){
        
        self.registerDate = registerDate
        self.isDoneArray = isDoneArray
        self.content = content
        self.isSun = isSun
        self.isMoon = isMoon
        
        
        
        self.typeSelection = typeSelection
        if typeSelection == .daysOfMonth {
            self.selectedDays = selectedDaysInMonth
        }
        else if typeSelection == .daysOfWeek {
            self.selectedDays = selectedDaysInWeek
        }
        else {
            self.selectedDate = selectedDate
        }
    }
}


extension Item : Identifiable {
    
}
