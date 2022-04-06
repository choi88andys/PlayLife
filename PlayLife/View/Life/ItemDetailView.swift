//
//  ItemDetailView.swift
//  PlayLife
//
//  Created by MacAndys on 2022/02/11.
//

import SwiftUI


struct ItemDetailView: View {
    var anItem: Item!
    @Binding var isActiveDetailView: Bool
    @Binding var isItemChanged: Bool
    
    let timer = Timer.publish(every: 0.012, on: .main, in: .common).autoconnect()
    @State var textWhen = ""
    @State var progressLabelForOnce = Strings.stringLabelUnfinished
    
    @State private var progressBarValueRecent: Double = 0
    @State private var progressBarValueTotal: Double = 0
    @State var achieveRateRecent: Double = 0
    @State var achieveRateTotal: Double = 0
    @State var isValidRecent: Bool = false
    @State var isValidTotal: Bool = false
    
    
    func calcAchieveRate(calendar: Calendar, today: Date, itemType: ItemType) {
        guard anItem.wrappedRegisterDate<=today else {
            isValidTotal = false
            isValidRecent = false
            return
        }
        
        // get denominator
        var recent: Double = 0
        var total: Double = 0
        for i in 0 ... calendar.dateComponents([.day], from: anItem.wrappedRegisterDate, to: today ).day! {
            if anItem.wrappedSelectedDays
                .contains(calendar.component(
                    itemType==ItemType.daysOfWeek ? .weekday : .day,
                    from: today.addingTimeInterval(SettingConstants.aDay * Double(-1 * i)) )) {
                
                total += 1
                if i <= SettingConstants.recentDayLimit {
                    recent += 1
                }
            }
        }
        isValidTotal = total==0 ? false : true
        isValidRecent = recent==0 ? false : true
        
        
        // get numerator
        var numeratorTotal: Double = 0
        var numeratorRecent: Double = 0
        for date in anItem.isDoneArray {
            if anItem.wrappedSelectedDays.contains(calendar.component(itemType==ItemType.daysOfWeek ? .weekday : .day, from: date)) &&
                date>=anItem.wrappedRegisterDate  {
                
                numeratorTotal += 1
                if date >= today.addingTimeInterval(SettingConstants.aDay * Double(SettingConstants.recentDayLimit * -1)) {
                    numeratorRecent += 1
                }
            }
        }
        achieveRateTotal = isValidTotal ? numeratorTotal*100/total : 0
        achieveRateRecent = isValidRecent ? numeratorRecent*100/recent : 0
    }
    
    
    var body: some View {
        return ScrollView {
            VStack {
                VStack(alignment: .leading) {
                    Text(anItem.wrappedContent)
                        .lineLimit(SettingConstants.detailedItemLineLimit)
                    CustomDivider(percentage: 0.9)
                        .padding(.top, SettingConstants.fontSize)
                    Text(textWhen)
                }
                .customStyle()
                .font(.system(size: SettingConstants.fontSize))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AddItemView(anItem: anItem, isActiveDetailView: $isActiveDetailView,
                                                                isItemChanged: $isItemChanged)
                        ) {
                            Image(systemName: "square.and.pencil")
                        }
                    }
                }
                
                
                VStack(spacing: SettingConstants.fontSize * 1.5) {
                    if anItem.typeSelection != ItemType.once {
                        CustomProgressView(label: Strings.stringRecent,
                                           progressValue: $progressBarValueRecent, isValid: $isValidRecent)
                        CustomDivider(percentage: 0.9)
                    }
                    CustomProgressView(label: anItem.typeSelection==ItemType.once ? progressLabelForOnce : Strings.stringTotal,
                                       progressValue: $progressBarValueTotal, isValid: $isValidTotal)
                }
                .customStyle()
                .font(.system(size: SettingConstants.fontSize))
                .onReceive(timer) { _ in
                    if progressBarValueRecent < min(SettingConstants.progressMaxValue, achieveRateRecent) {
                        progressBarValueRecent += 1
                    }
                    if progressBarValueTotal < min(SettingConstants.progressMaxValue, achieveRateTotal) {
                        progressBarValueTotal += 1
                    }
                }
            }
        }
        .navigationTitle(Strings.itemDetailViewTitle)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            let count = anItem.wrappedSelectedDays.count
            
            switch anItem.typeSelection {
            case ItemType.once:
                textWhen = anItem.wrappedSelectedDate.getString(withoutYear: false)
                textWhen += SettingConstants.stringForOnceEnding
                
                if anItem.wrappedSelectedDate > today {
                    isValidTotal = false
                }
                else {
                    isValidTotal = true
                    if anItem.isDoneArray.contains(anItem.wrappedSelectedDate) {
                        achieveRateTotal = SettingConstants.progressMaxValue-1
                        progressLabelForOnce = Strings.stringLabelFinished
                    }
                    else {
                        progressLabelForOnce = Strings.stringLabelUnfinished
                    }
                }
                
                
            case ItemType.daysOfWeek:
                if count == ItemType.daysOfWeek.rawValue {
                    textWhen = SettingConstants.stringForEveryday
                }
                else {
                    textWhen = SettingConstants.stringEveryWeekStarting
                    
                    let isLongText = count>SettingConstants.manyDaysInWeek ? false : true
                    for i in 0..<count {
                        textWhen += anItem.wrappedSelectedDays[i].getWeekdayAsKorean(longText: isLongText)
                        
                        if i != count-1 {
                            textWhen += Strings.stringComma
                        }
                    }
                    if !isLongText {
                        textWhen += SettingConstants.stringWeekdayEnding
                    }
                    textWhen += SettingConstants.stringForWeekAndMonthEnding
                }
                calcAchieveRate(calendar: calendar, today: today, itemType: .daysOfWeek)
                
                
            case ItemType.daysOfMonth:
                if count == ItemType.daysOfMonth.rawValue {
                    textWhen = SettingConstants.stringForEveryday
                }
                else {
                    textWhen = SettingConstants.stringEveryMonthStarting
                    
                    for i in 0..<count {
                        textWhen += anItem.wrappedSelectedDays[i].getDayAsKorean()
                        
                        if i != count-1 {
                            textWhen += Strings.stringComma
                        }
                    }
                    textWhen += SettingConstants.stringForWeekAndMonthEnding
                }
                calcAchieveRate(calendar: calendar, today: today, itemType: .daysOfMonth)
            } // end of switch
        } // end of onAppear
    } // end of body
}



struct CustomProgressView: View {
    var label: String
    @Binding var progressValue: Double
    @Binding var isValid: Bool
    
    
    let gradeOne: Double = 33
    let gradeTwo: Double = 66
    let gradeThree: Double = SettingConstants.progressMaxValue
    
    func getColor(value: Double, isBadgeColor: Bool = false) -> Color {
        var color: Color
        
        switch value {
        case 0..<gradeOne :
            color = .red
        case gradeOne..<gradeTwo :
            color = .green
        case gradeTwo..<gradeThree :
            color = .blue
        default :
            color = isBadgeColor ? .yellow : .blue
        }
        
        return color
    }
    
    func getBadge(value: Double) -> Image {
        var image: Image
        
        switch value {
        case 0..<gradeOne :
            image = Image(systemName: "exclamationmark.square")
        case gradeOne..<gradeTwo :
            image = Image(systemName: "triangle")
        case gradeTwo..<gradeThree :
            image = Image(systemName: "circle")
        default :
            image = Image(systemName: "star.fill")
        }
        
        return image
    }
    
    var body: some View {
        HStack {
            ProgressView(label, value: progressValue, total: SettingConstants.progressMaxValue)
                .tint(getColor(value: progressValue))
            
            Group {
                if isValid {
                    getBadge(value: progressValue)
                        .foregroundColor(getColor(value: progressValue, isBadgeColor: true))
                }
                else {
                    Image(systemName: "questionmark")
                }
            }
            .frame(width: SettingConstants.fontSize * 2)
        }
    }
}
