//
//  AddItemView.swift
//  PlayLife
//
//  Created by MacAndys on 2021/12/29.
//

import SwiftUI
import FSCalendar


struct AddItemView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    var anItem: Item? = nil
    @Binding var isActiveDetailView: Bool
    @Binding var isItemChanged: Bool
    
    let registerDate = Calendar.current.startOfDay(for: Date())
    var currentCalendar = Calendar.current
    
    // once
    @State var selectedDate: Date? = Calendar.current.startOfDay(for: Date())
    @State var prevDate: Date? = nil
    
    // week
    @State var selectedDaysInWeek: [Int] = [Int]()
    @State var isDaySelectedInWeek: [Bool] = [Bool]()
    
    // month
    @State var selectedDaysInMonth: [Int] = [Int]()
    @State var isDaySelectedInMonth: [Bool] = [Bool]()
    
    
    @State var typeSelection: ItemType = .daysOfWeek
    @State var content: String = Strings.placeholderString
    @State var isSun: Bool = true
    @State var isMoon: Bool = true
    @State var isExpanded: Bool = false
    var isValid: Bool {
        get {
            if content==Strings.placeholderString ||
                content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                !isExpanded {
                return false
            }
            else {
                return true
            }
        }
    }
    enum FocusField: Hashable {
        case field
    }
    @FocusState private var focusedField: FocusField?
    
    @State var isFinishedOnAppear: Bool = false
    @State var showingDeleteAlert: Bool = false
    
    
    var body: some View {
        return ScrollView(showsIndicators: false) {
            VStack {
                TextEditor(text: $content)
                    .disableAutocorrection(true)
                    .foregroundColor(content==Strings.placeholderString ? Color.gray : Color.primary)
                    .font(.system(size: SettingConstants.fontSize*1))
                    .frame(height: SettingConstants.textEditorHeight)
                    .customStyle(innerPadding: SettingConstants.fontSize*0.4)
                    .focused($focusedField, equals: .field)
                    .onChange(of: focusedField) { newValue in
                        if newValue != nil &&
                            content==Strings.placeholderString {
                            content = ""
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .keyboard) {
                            /*
                             A layout warning occurs when the keyboard appears.
                             And when this app going background after hiding keyboard, the snapshot warning occurred.
                             But it works well.
                             */
                            HStack {
                                Spacer()
                                Text(Strings.stringDone)
                                    .foregroundColor(Color.blue)
                                    .padding(.trailing, SettingConstants.edgePadding)
                                    .onTapGesture {
                                        focusedField = nil
                                    }
                            }
                        }
                        
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            HStack(spacing: SettingConstants.fontSize*0.7) {
                                if anItem != nil {
                                    Image(systemName: "xmark.circle")
                                        .foregroundColor(Color.red)
                                        .onTapGesture {
                                            showingDeleteAlert = true
                                        }
                                        .alert(isPresented: $showingDeleteAlert) {
                                            Alert(title: Text(Strings.stringAlertForDelete),
                                                  message: nil,
                                                  primaryButton: .destructive(
                                                    Text(Strings.stringDelete),
                                                    action: {
                                                        moc.delete(anItem!)
                                                        if moc.hasChanges {
                                                            try? moc.save()
                                                        }
                                                        
                                                        isItemChanged = true
                                                        isActiveDetailView = false                                                        
                                                    }),
                                                  secondaryButton: .cancel(
                                                    Text(Strings.stringCancel)
                                                  )
                                            )
                                        }
                                }
                                
                                
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(isValid ? Color.blue : Color.gray)
                                    .onTapGesture {
                                        if isValid {
                                            let trimmedContent = content.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                                            
                                            if let item = anItem {
                                                item.addData(registerDate: item.wrappedRegisterDate,
                                                             isDoneArray: item.isDoneArray,
                                                             content: trimmedContent, isSun: isSun, isMoon: isMoon,
                                                             typeSelection: typeSelection,
                                                             selectedDaysInMonth: selectedDaysInMonth.sorted(),
                                                             selectedDaysInWeek: selectedDaysInWeek.sorted(),
                                                             selectedDate: currentCalendar.startOfDay(for: selectedDate!)
                                                )
                                            }
                                            else {
                                                let item = Item(context: moc)
                                                item.addData(registerDate: registerDate,
                                                             content: trimmedContent, isSun: isSun, isMoon: isMoon,
                                                             typeSelection: typeSelection,
                                                             selectedDaysInMonth: selectedDaysInMonth.sorted(),
                                                             selectedDaysInWeek: selectedDaysInWeek.sorted(),
                                                             selectedDate: currentCalendar.startOfDay(for: selectedDate!)
                                                )
                                            }
                                            if moc.hasChanges {
                                                try? moc.save()
                                            }
                                            
                                            
                                            if isActiveDetailView {
                                                isItemChanged = true
                                                isActiveDetailView = false                                                
                                            } else {
                                                dismiss()
                                            }
                                            
                                        }
                                    }
                            }
                        } // end of HStack contained check and X mark
                    } // end of TextEditor with toolbar
                
                
                
                VStack {
                    if !isExpanded {
                        HStack {
                            Spacer()
                            Text(Strings.stringWhenTodo)
                            Spacer()
                            Image(systemName: "chevron.down")
                        }
                        .font(.system(size: SettingConstants.fontSize * 1))                        
                        .background(Color.background)
                        .onTapGesture {
                            withAnimation {
                                isExpanded = true
                            }
                        }
                    }
                    else {
                        HStack(spacing: SettingConstants.fontSize*0.2) {
                            Spacer()
                            TypeSelectView(typeSelection: $typeSelection)
                            Spacer()
                            Spacer()
                            SunAndMoonView(isSun: $isSun, isMoon: $isMoon)
                                .font(.system(size: SettingConstants.fontSize*1.2))
                            Spacer()
                        }
                        
                        
                        VStack {
                            CustomDivider(percentage: 0.9)
                                .padding(.top, SettingConstants.fontSize*0.3)
                                .padding(.bottom, SettingConstants.fontSize*0.8)
                            
                            if isFinishedOnAppear {
                                switch typeSelection {
                                case .once:
                                    CalendarModuleView(prevDate: prevDate, selectedDate: $selectedDate)
                                        .frame(width: UIScreen.main.bounds.width*0.85, height: SettingConstants.fontSize*24)
                                    
                                case .daysOfWeek:
                                    WeekdayView(days: $selectedDaysInWeek, isDaySelected: $isDaySelectedInWeek)
                                    
                                case .daysOfMonth:
                                    DaysOfMonthView(days: $selectedDaysInMonth, isDaySelected: $isDaySelectedInMonth)
                                }
                            }
                            
                            WantedTimeView(typeSelection: $typeSelection, isSun: $isSun, isMoon: $isMoon)
                        }
                        .font(.system(size: SettingConstants.fontSize*1.1))
                    }
                } // end of date selection
                .customStyle()
                
            } // end of VStack
        } // end of ScrollView
        .navigationTitle(isActiveDetailView ? Strings.addItemViewTitleForEdit : Strings.addItemViewTitleForAdd)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if !isFinishedOnAppear {
                // Set default state
                for _ in 0..<ItemType.daysOfWeek.rawValue {
                    isDaySelectedInWeek.append(false)
                }
                for _ in 0..<ItemType.daysOfMonth.rawValue {
                    isDaySelectedInMonth.append(false)
                }
                                
                let components = currentCalendar.dateComponents([.day, .weekday], from: registerDate)
                let registerDay = components.day ?? 1
                let registerWeekday = components.weekday ?? 1
                                
                // Mark registerDate as true
                selectedDaysInWeek.append(registerWeekday)
                isDaySelectedInWeek[registerWeekday-1] = true
                selectedDaysInMonth.append(registerDay)
                isDaySelectedInMonth[registerDay-1] = true
                
                
                if let existingItems = anItem {
                    isExpanded = true
                    
                    content = existingItems.wrappedContent
                    isSun = existingItems.isSun
                    isMoon = existingItems.isMoon
                    
                    typeSelection = existingItems.typeSelection
                    switch typeSelection {
                    case .once:
                        prevDate = existingItems.wrappedSelectedDate
                        if existingItems.wrappedSelectedDate >= registerDate {
                            selectedDate = existingItems.wrappedSelectedDate
                        }
                        
                    case .daysOfWeek:
                        // Rollback to default state
                        selectedDaysInWeek = [Int]()
                        isDaySelectedInWeek[registerWeekday-1] = false
                        
                        // Set value from items
                        for i in 0..<existingItems.wrappedSelectedDays.count {
                            selectedDaysInWeek.append(existingItems.wrappedSelectedDays[i])
                            isDaySelectedInWeek[existingItems.wrappedSelectedDays[i] - 1] = true
                        }
                        
                    case .daysOfMonth:
                        // Rollback to default state
                        selectedDaysInMonth = [Int]()
                        isDaySelectedInMonth[registerDay-1] = false
                        
                        // Set value from items
                        for i in 0..<existingItems.wrappedSelectedDays.count {
                            selectedDaysInMonth.append(existingItems.wrappedSelectedDays[i])
                            isDaySelectedInMonth[existingItems.wrappedSelectedDays[i] - 1] = true
                        }
                    }
                }
            }
            
            isFinishedOnAppear = true
        } // end of onAppear
    } // end of body
    
    
    
    // 7
    struct WeekdayView: View {
        @Binding var days: [Int]
        @Binding var isDaySelected: [Bool]
        
        var body: some View {
            return HStack(spacing: SettingConstants.fontSize * 0.7) {
                ForEach(0..<Int(ItemType.daysOfWeek.rawValue), id: \.self) { i in
                    WeekdayCircle(days: $days, num: i, isSelected: $isDaySelected[i])
                }
            }
        }
        
        struct WeekdayCircle: View {
            @Binding var days: [Int]
            let num: Int
            @Binding var isSelected: Bool
            
            var body: some View {
                let text = (num+1).getWeekdayAsKorean(longText: false)
                
                return Circle()
                    .customCircle(text: text, color: Color.skyBlue, isSelected: isSelected)
                    .onTapGesture {
                        if isSelected {
                            if days.count > 1 {
                                isSelected.toggle()
                                days = days.filter() {
                                    $0 != num+1
                                }
                            }
                        } else {
                            isSelected.toggle()
                            days.append(num+1)
                        }
                    }
            }
        }
    }
    
    
    // 31
    struct DaysOfMonthView: View {
        @Binding var days: [Int]
        @Binding var isDaySelected: [Bool]
        
        var body: some View {
            let spacing = SettingConstants.fontSize * 0.33
            return VStack {
                ForEach(0..<4, id: \.self) { j in
                    HStack(spacing: spacing) {
                        ForEach(j*7..<(j+1)*7, id: \.self) { i in
                            DayView(days: $days , num: i, isSelected: $isDaySelected[i])
                        }
                    }
                    CustomDivider(percentage: 0.75)
                }
                HStack(spacing: spacing) {
                    ForEach(28..<31, id: \.self) { i in
                        DayView(days: $days , num: i, isSelected: $isDaySelected[i])
                    }
                    
                    // placeholder
                    ForEach(31..<35, id: \.self) { _ in
                        Image(systemName: "35.circle")
                            .opacity(0)
                    }
                }
            } // end V
            .foregroundColor(Color.skyBlue)
            .font(.system(size: SettingConstants.fontSize*2.1))
        }
        
        struct DayView: View {
            @Binding var days: [Int]
            var num: Int
            @Binding var isSelected: Bool
            
            var body: some View {
                let name1: String = "\(num+1).circle"
                let name2: String = "\(num+1).circle.fill"
                
                if isSelected {
                    Image(systemName: name2)
                        .onTapGesture {
                            if days.count > 1 {
                                isSelected.toggle()
                                days = days.filter() {
                                    $0 != num+1
                                }
                            }
                        }
                }
                else {
                    Image(systemName: name1)
                        .onTapGesture {
                            isSelected.toggle()
                            days.append(num+1)
                        }
                }
            }
        }
    } // end of DaysOfMonthView
    
    
    struct WantedTimeView: View {
        @Binding var typeSelection: ItemType
        @Binding var isSun: Bool
        @Binding var isMoon: Bool
        
        var body: some View {
            return VStack {
                CustomDivider(percentage: 0.9)
                    .padding(.top, SettingConstants.fontSize*0.8)
                
                switch typeSelection {
                case .once:
                    Text(Strings.stringWantedTimeOnce)
                case .daysOfWeek:
                    Text(Strings.stringWantedTimeWeek)
                case .daysOfMonth:
                    Text(Strings.stringWantedTimeMonth)
                }
                
                
                if isSun && !isMoon {
                    Text(Strings.stringWantedTimeDaytime)
                }
                else if !isSun && isMoon {
                    Text(Strings.stringWantedTimeNighttime)
                }
                else {
                    Text(Strings.stringWantedTimeAnytime)
                }
            }
        }
    }
    
} // end AddItemView







