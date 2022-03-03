//
//  Enemy+CoreDataProperties.swift
//  
//
//  Created by MacAndys on 2022/01/25.
//
//

import Foundation
import CoreData


/*
 @State var isOnPassion: Bool = false
 @State var isOnCourage: Bool = false
 @State var isOnEndurance: Bool = false
 @State var isOnKindness: Bool = false
 */



enum WeakPoint: Int32, CaseIterable {
    case passion = 0
    case courage = 1
    case endurance = 2
    case kindness = 3
}

extension Enemy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Enemy> {
        return NSFetchRequest<Enemy>(entityName: "Enemy")
    }

    @NSManaged public var name: String?
    @NSManaged public var level: Int32
    @NSManaged public var health: Double
    @NSManaged public var weakPointValue: Int32
    @NSManaged public var defeatCount: Int32

    
            
    public var wrappedName: String {
        name ?? ""
    }
    
    var weakPoint: WeakPoint {
        get {
            return WeakPoint(rawValue: weakPointValue)!
        }
        set {
            weakPointValue = newValue.rawValue
        }
    }
    
    
    
    func nextLevel(name: String, isFirst: Bool = false) {
        self.name = name
        if isFirst {
            level = 1
        } else {
            level += 1
        }
        health = calcHealth()
        weakPoint = WeakPoint.allCases.randomElement()!
        defeatCount = 0
    }
    
    func calcHealth() -> Double {
        var result: Double = 0
        var multiplier: Double = 0
        
        if level%10 == 0 {
            multiplier = Double.random(in: 2.1 ... 2.5)
        }
        else {
            multiplier = Double.random(in: 1.8 ... 2.2)
        }
        result = (Double(level) * multiplier) + 5*log2(Double(level))
        
        
        return result
    }
                    
}



