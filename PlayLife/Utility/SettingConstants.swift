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
    static let appNameForPromotion: String = "Play Life"
    static let introMessage: String = "당신을 표현하는 단어를\n모두 선택해 주세요."
    
    static let stringKeyTalent = "talent"
    static let stringKeyPassion = "passion"
    static let stringKeyCourage = "courage"
    static let stringKeyEndurance = "endurance"
    static let stringKeyKindness = "kindness"
    static let stringKeyIsFirstLaunched = "isFirstLaunched"
    static let stringKeyTomorrow = "tomorrow"
    
    
            
    
    // Status
    static let statusViewProportion: Double = 0.19
    static let startingStatus: Int = 12 * 2
    static let talentPerStatus: Int = 5
    static let talentPerTodayItem: Int = 3
    static let talentPerPastItem: Int = 1
    static let maximumTalentPerWin: Int = 4
    static let minimumTalentPerWin: Int = 1
    
    
    static let stringPassion = "열정"
    static let stringCourage = "용기"
    static let stringEndurance = "인내"
    static let stringKindness = "친절"
    
    
    
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
    static let placeholderString: String = "내용을 입력해 주세요."
    static let typeChangeDuration: Double = 0.25
    
    static let todayItemLineLimit: Int = 3
    static let registeredItemLineLimit: Int = 2
    static let detailedItemLineLimit: Int = 20
    
    static let progressMaxValue: Double = 100
    static let recentDayLimit: Int = 30
    static let manyDaysInWeek: Int = 4
    
    static let todayViewTitle = "리스트"
    static let registeredItemViewTitle = "전체 일정"
    static let itemDetailViewTitle = "자세히"
    static let addItemViewTitleForAdd = "추가하기"
    static let addItemViewTitleForRevise = "수정하기"
    
    static let stringDone = "완료"
    static let stringAlertForDelete = "일정을 삭제할까요?"
    static let stringDelete = "삭제"
    static let stringCancel = "취소"
    
    
    static let stringToday = "오늘"
    static let stringTomorrow = "내일"
    static let stringYesterday = "어제"
    static let stringRecent = "최근"
    static let stringTotal = "전체"
    static let stringComma = ", "
    static let stringEveryWeekStarting = "매주 "
    static let stringEveryMonthStarting = "매월 "
    
    static let stringWhenTodo = "언제 할까요?"
    
    static let stringForOnceEnding = "에 하면 돼요."
    static let stringForEveryday = "매일 반복해서 하고 있어요."
    static let stringForWeekAndMonthEnding = "마다 반복해서 하고 있어요."
    static let stringWeekdayEnding = "요일"
        
    
    static let stringLabelFinished = "완료했어요!"
    static let stringLabelUnfinished = "아직 안 했어요!"
    
    static let stringWantedTimeOnce = "선택한 날짜에 한 번만 하면 돼요."
    static let stringWantedTimeWeek = "매주 선택한 요일에 반복해서 할 거예요."
    static let stringWantedTimeMonth = "매월 선택한 날짜에 반복해서 할 거예요."
    
    static let stringWantedTimeDaytime = "하루 중 낮 시간에 하고 싶어요."
    static let stringWantedTimeNighttime = "하루 중 저녁 시간에 하고 싶어요."
    static let stringWantedTimeAnytime = "하루 중 언제 해도 상관없어요."
    
    static let stringForEmptyDay: LocalizedStringKey = "\(Image(systemName: "plus.circle")) 버튼으로 새로운 일정을 추가할 수 있어요!"
    static let stringForEmptyRegister = "등록된 일정이 없어요!"
    
    static let calendarLocaleIdentifier: String = "ko_KR"
    static let calendarHeaderDateFormat = "YYYY년   M월"
    
    
    
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
    
    
    static let fileNamePrev = "prev_kor"
    static let fileNameNoun = "noun_kor"
    static let fileType = "txt"
    static let separator = "\n"
    
    static let loadFailed = "load failed"
    static let notFounded = "not founded"
    
    static let stringWin = "승리했습니다!"
    static let stringLose = "패배했습니다!"
    static let stringForWho = "에게"
    static let stringHowMany = "명을 괴롭힌"
    
    
    static let stringHintPassion = "열정적으로 도전하면 해낼 수 있을 거예요."
    static let stringHintCourage = "용기를 내서 직면하면 길이 보일지도 몰라요."
    static let stringHintEndurance = "때로는 인내하며 버티는 것이 정답일 수도 있어요."
    static let stringHintKindness = "따뜻하게 친절을 베풀면 도움이 될지도 몰라요."
    
    
    
    
}





