//
//  UserStatus.swift
//  PlayLife
//
//  Created by MacAndys on 2021/12/22.
//

import Foundation

class UserStatus: ObservableObject {
    static let shared = UserStatus()
                
    
    @Published var talent: Int = UserDefaults.talent
    @Published var passion: Int = UserDefaults.passion
    @Published var courage: Int = UserDefaults.courage
    @Published var endurance: Int = UserDefaults.endurance
    @Published var kindness: Int = UserDefaults.kindness
    
    
    func setCurrentData() {
        UserDefaults.talent = talent
        UserDefaults.passion = passion
        UserDefaults.courage = courage
        UserDefaults.endurance = endurance
        UserDefaults.kindness = kindness
    }
    
    init(){
        talent = UserDefaults.talent
        passion = UserDefaults.passion
        courage = UserDefaults.courage
        endurance = UserDefaults.endurance
        kindness = UserDefaults.kindness
    }
    
    
    #if DEBUG
    convenience init(_ a: Int, _ b: Int, _ c: Int, _ d: Int, _ e: Int ){
        self.init()
        talent = a
        passion = b
        courage = c
        endurance = d
        kindness = e
    }
    #endif
     
    
}

