//
//  UserDefaults+optionalValue.swift
//  PlayLife
//
//  Created by MacAndys on 2021/12/21.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    var container: UserDefaults

    var wrappedValue: T {
        get {
            return container.object(forKey: key) as? T ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
    
    init(key: String, defaultValue: T, container: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.container = container
        
    }
}


extension UserDefaults {
    @UserDefault(key: SettingConstants.stringKeyTalent, defaultValue: 0)
    static var talent: Int
    @UserDefault(key: SettingConstants.stringKeyPassion, defaultValue: 0)
    static var passion: Int
    @UserDefault(key: SettingConstants.stringKeyCourage, defaultValue: 0)
    static var courage: Int
    @UserDefault(key: SettingConstants.stringKeyEndurance, defaultValue: 0)
    static var endurance: Int
    @UserDefault(key: SettingConstants.stringKeyKindness, defaultValue: 0)
    static var kindness: Int
    
    @UserDefault(key: SettingConstants.stringKeyIsFirstLaunched, defaultValue: true)
    static var isFirstLaunched: Bool
    @UserDefault(key: SettingConstants.stringKeyTomorrow, defaultValue: Date())
    static var tomorrow: Date
}


