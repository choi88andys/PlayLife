//
//  TodayView.swift
//  PlayLife
//
//  Created by MacAndys on 2021/12/21.
//

import SwiftUI
import CoreData


struct TodayView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\Item.registerDate, order: .reverse),
        SortDescriptor(\Item.itemType),
        SortDescriptor(\Item.content)
    ]) var items: FetchedResults<Item>
    @State private var selection: NSManagedObjectID!
    
    
    let timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
    @State private var currentCalendar: Calendar = Calendar.autoupdatingCurrent
    @State private var currentDate: Date = Calendar.current.startOfDay(for: Date())
    @State private var selectedDate: Date? = Calendar.current.startOfDay(for: Date())
    @State private var scrollTodayToggle: Bool = false
    @State private var swipeDirection: UnitPoint?
    @State private var displayedItemCount: Int = 0
    
    
    @State var showStar: Bool = false
    @State var isSun: Bool = true
    @State var isMoon: Bool = true
    
    
    
    var body: some View {
        
        let detectDirectionalDrags = DragGesture(
            minimumDistance: SettingConstants.swipeDetectDistance, coordinateSpace: .local)
            .onEnded { value in
                if (value.translation.width < 0) &&
                    (value.translation.height > SettingConstants.swipeDetectHeightLimit * -1) &&
                    (value.translation.height < SettingConstants.swipeDetectHeightLimit) {
                    if selectedDate! < currentDate.addingTimeInterval(
                        SettingConstants.aDay * Double(SettingConstants.endDateLimit)) {
                        
                        swipeDirection = .leading
                        selectedDate = selectedDate?.addingTimeInterval(SettingConstants.aDay * 1)
                    }
                }
                else if (value.translation.width > 0) &&
                            (value.translation.height > SettingConstants.swipeDetectHeightLimit * -1) &&
                            (value.translation.height < SettingConstants.swipeDetectHeightLimit) {
                    if selectedDate! > currentDate.addingTimeInterval(
                        SettingConstants.aDay * Double(SettingConstants.startDateLimit * -1)) {
                        
                        swipeDirection = .trailing
                        selectedDate = selectedDate?.addingTimeInterval(SettingConstants.aDay * -1)
                    }
                }
            }
        
        return VStack {
            StatusLabel(fontName: SettingConstants.fontNameLife, fontSize: SettingConstants.fontSize * 1.15)
            
            HStack {
                HStack(spacing: SettingConstants.fontSize*1) {
                    NavigationLink(
                        destination: AddItemView(isActiveDetailView: .constant(false), isItemChanged: .constant(false))
                    ) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: SettingConstants.fontSize*2.2))
                    }
                    .isDetailLink(false)
                    
                    NavigationLink(
                        destination: RegisteredItemView()
                    ) {
                        Image(systemName: "doc.text.magnifyingglass")
                            .font(.system(size: SettingConstants.fontSize*1.9))
                    }
                    .isDetailLink(false)
                }
                .foregroundColor(Color.skyBlue)
                .frame(width: UIScreen.main.bounds.width * 0.25)
                
                
                Spacer()
                if selectedDate != nil {
                    Group {
                        if currentCalendar.isDateInToday(selectedDate!) {
                            Text(Strings.stringToday)
                        }
                        else if currentCalendar.isDateInYesterday(selectedDate!) {
                            Text(Strings.stringYesterday)
                        }
                        else if currentCalendar.isDateInTomorrow(selectedDate!) {
                            Text(Strings.stringTomorrow)
                        }
                        else {
                            if currentCalendar.component(.year, from: selectedDate!) ==
                                currentCalendar.component(.year, from: currentDate) {
                                Text(selectedDate!.getString(withoutYear: true))
                            }
                            else {
                                Text(selectedDate!.getString(withoutYear: false))
                            }
                        }
                    }
                    .font(.system(size: SettingConstants.fontSize*1.4))
                    .frame(width: UIScreen.main.bounds.width * 0.45)
                    .onTapGesture {
                        selectedDate = currentDate
                        scrollTodayToggle.toggle()
                    }
                }
                Spacer()
                
                SunAndMoonView(isSun: $isSun, isMoon: $isMoon)
                    .font(.system(size: SettingConstants.fontSize*1.2))
                    .frame(width: UIScreen.main.bounds.width * 0.25)
            }
            .padding(.bottom, SettingConstants.fontSize*0.25)
            .padding(.horizontal, SettingConstants.edgePadding)
            
            
            HorizontalCalendarView(currentDate: $currentDate,
                                   selectedDate: $selectedDate,
                                   scrollTodayToggle: $scrollTodayToggle,
                                   swipeDirection: $swipeDirection)
            
            
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(items) { item in
                            if ((isSun && item.isSun)||(isMoon && item.isMoon)) &&
                                selectedDate! >= item.wrappedRegisterDate {
                                
                                if (item.typeSelection==ItemType.once &&
                                    item.wrappedSelectedDate==selectedDate) ||
                                    (item.typeSelection==ItemType.daysOfWeek &&
                                     item.selectedDays!.contains(currentCalendar.component(.weekday, from: selectedDate!))) ||
                                    (item.typeSelection==ItemType.daysOfMonth &&
                                     item.selectedDays!.contains(currentCalendar.component(.day, from: selectedDate!))) {
                                                                        
                                    if showStar && selection==item.objectID {
                                        ShowingStarView()
                                    }
                                    if !item.isDoneArray.contains(selectedDate!) {
                                        ItemView(item: item,
                                                 isDone: false,
                                                 selection: $selection,
                                                 showStar: $showStar,
                                                 currentDate: $currentDate,
                                                 selectedDate: selectedDate!,
                                                 displayedItemCount: $displayedItemCount)
                                    }
                                }
                            }
                        } // end of first ForEach
                        
                        
                        if displayedItemCount != 0 {
                            CustomDivider(percentage: 0.95)
                                .padding(.vertical, SettingConstants.fontSize * 1.1)
                        }
                        
                        
                        ForEach(items) { item in
                            if item.isDoneArray.contains(selectedDate!) &&
                                ((isSun && item.isSun)||(isMoon && item.isMoon)) &&
                                selectedDate! >=  item.wrappedRegisterDate {
                                
                                if (item.typeSelection==ItemType.once &&
                                    item.wrappedSelectedDate==selectedDate) ||
                                    (item.typeSelection==ItemType.daysOfWeek &&
                                     item.selectedDays!.contains(currentCalendar.component(.weekday, from: selectedDate!))) ||
                                    (item.typeSelection==ItemType.daysOfMonth &&
                                     item.selectedDays!.contains(currentCalendar.component(.day, from: selectedDate!))) {
                                    
                                    ItemView(item: item,
                                             isDone: true,
                                             selection: $selection,
                                             showStar: $showStar,
                                             currentDate: $currentDate,
                                             selectedDate: selectedDate!,
                                             displayedItemCount: $displayedItemCount)
                                }
                            }
                        } // end of second ForEach
                    }
                } // end ScrollView
                
                
                if displayedItemCount == 0 {
                    VStack {
                        NavigationLink(
                            destination: AddItemView(isActiveDetailView: .constant(false), isItemChanged: .constant(false))
                        ) {
                            // Text("\(Image(systemName: "plus.circle")) \(Strings.stringForEmptyDay)")
                            Text(Strings.stringForEmptyDay)
                                .foregroundColor(Color.gray)
                                .font(.system(size: SettingConstants.fontSize))
                        }
                        .isDetailLink(false)
                        Spacer()
                    }
                }
            }
            .contentShape(Rectangle())
            .gesture(detectDirectionalDrags)
            
            
        } // end of VStack
        .navigationTitle(Strings.todayViewTitle)
        .navigationBarHidden(true)
        .onAppear {
            currentDate = currentCalendar.startOfDay(for: Date())
        }
        .onReceive(timer) { _ in
            currentDate = currentCalendar.startOfDay(for: Date())
            
            
            if currentDate >= UserDefaults.tomorrow {
                let date = currentDate.addingTimeInterval(SettingConstants.aDay * 1)
                UserDefaults.tomorrow = date
                
                currentCalendar = Calendar.autoupdatingCurrent
            }
        }
    } // end body
    
    
    
    
    
    struct ItemView: View {
        @Environment(\.managedObjectContext) var moc
        @EnvironmentObject var userStatus: UserStatus
        
        var item: Item
        let isDone: Bool
        @Binding var selection: NSManagedObjectID!
        @Binding var showStar: Bool
        @Binding var currentDate: Date
        var selectedDate: Date
        @Binding var displayedItemCount: Int
        
        
        @State var isActiveDetailView: Bool = false
        
        
        var body: some View {
            return HStack {
                Text(item.wrappedContent)
                    .strikethrough(isDone)
                    .lineLimit(SettingConstants.todayItemLineLimit)
                
                Spacer()
                NavigationLink(destination: ItemDetailView(anItem: item, isActiveDetailView: $isActiveDetailView,
                                                           isItemChanged: .constant(false)),
                               isActive: $isActiveDetailView
                ) {
                    Image(systemName: "ellipsis.circle")
                        .foregroundColor(.primary)
                        .font(.system(size: SettingConstants.fontSize*1.3))
                }
            }
            .todayItemStyle(isDone: isDone)
            .onTapGesture {
                if selectedDate <= currentDate {
                    let isTodayItem: Bool = selectedDate==currentDate
                    
                    // consistency issue.
                    if isDone {
                        userStatus.talent -= isTodayItem ? SettingConstants.talentPerTodayItem : SettingConstants.talentPerPastItem
                        item.isDoneArray = item.isDoneArray.filter() {
                            $0 != selectedDate
                        }
                    }
                    else {
                        userStatus.talent += isTodayItem ? SettingConstants.talentPerTodayItem : SettingConstants.talentPerPastItem
                        item.isDoneArray.append(selectedDate)
                    }
                    
                    
                    UserDefaults.talent = userStatus.talent
                    UserDefaults.standard.synchronize()
                    if moc.hasChanges {
                        try? moc.save()
                    }
                    
                    if !isDone {
                        selection = item.objectID
                        showStar = true
                        withAnimation(.easeInOut(duration: SettingConstants.talentUpDuration)) {
                            showStar = false
                        }
                    }
                }
            } // end of tap gesture
            .onAppear {
                displayedItemCount += 1
            }
            .onDisappear {
                displayedItemCount -= 1
            }
        }
    }
}





struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
            .environmentObject(UserStatus())
            .previewDevice(PreviewDevice(rawValue: "iPhone 8 Plus"))
            .previewDisplayName("8 Plus")
        
    }
}


