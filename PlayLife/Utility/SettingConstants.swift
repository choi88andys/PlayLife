//
//  SettingConstants.swift
//  PlayLife
//
//  Created by MacAndys on 2021/12/22.
//


import SwiftUI


// It will be divided into several files.
struct SettingConstants {
    // Common
    static let isPhone = (UIDevice.current.userInterfaceIdiom == .phone)
    static let fontSize: CGFloat = isPhone ? 16 : 34
    static let edgePadding: CGFloat = isPhone ? 8 : 16
    static let overlayTextSize: CGFloat = isPhone ? 40 : 60
    static let overlayLineWidth: CGFloat = isPhone ? 1.5 : 2.5
        
    static let stringKeyTalent = "talent"
    static let stringKeyPassion = "passion"
    static let stringKeyCourage = "courage"
    static let stringKeyEndurance = "endurance"
    static let stringKeyKindness = "kindness"
    static let stringKeyIsFirstLaunched = "isFirstLaunched"
    static let stringKeyTomorrow = "tomorrow"
    
    static let isEnglish: Bool = Strings.isEnglish=="true"
                
    
    // Status
    static let statusViewProportion: Double = 0.19
    static let startingStatus: Int = 12 * 2
    static let talentPerStatus: Int = 5
    static let talentPerTodayItem: Int = 3
    static let talentPerPastItem: Int = 1
    static let maximumTalentPerWin: Int = 4
    static let minimumTalentPerWin: Int = 1
    
    
    
    // Life
    static let fontNameLife = "D2Coding"
    static let aDay: Double = 86400
    static let startDateLimit: Int = 30
    static let endDateLimit: Int = 365 * 1
    static let swipeDetectDistance: Double = 15
    static let swipeDetectHeightLimit: Double = 100
    
    static let talentUpDuration: Double = 0.6
    static let doneItemOpacity: Double = 0.35
    static let shadowY: CGFloat = 2.8
    static let shadowRadius: CGFloat = 0
    
    static let textEditorHeight: CGFloat = fontSize * 8    
    static let typeChangeDuration: Double = 0.25
    
    static let todayItemLineLimit: Int = 3
    static let registeredItemLineLimit: Int = 2
    static let detailedItemLineLimit: Int = 20
    
    static let progressMaxValue: Double = 100
    static let recentDayLimit: Int = 30
    static let manyDaysInWeek: Int = 4
    
    
    
    
    // Play
    static let fontNamePlay = "NeoDunggeunmoPro-Regular"
    
    static let weakPointMultiplier: Double = 1.6
    static let animateDurationVeryShort: Double = 0.15
    static let animateDurationShort: Double = 0.25
    static let animateDurationStandard: Double = 0.5
    static let animateDurationLong: Double = 0.6
    static let animateDurationVeryLong: Double = 1.1
    
    static let timerInterval: Double = 0.1
    static let tryCountForHint: Int32 = 5
    
    
}





