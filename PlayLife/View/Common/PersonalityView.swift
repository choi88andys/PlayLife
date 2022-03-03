//
//  PersonalityView.swift
//  PlayLife
//
//  Created by MacAndys on 2021/12/21.
//

import SwiftUI



struct PersonalityView: View {
    @EnvironmentObject var userStatus: UserStatus
    
    @State var isOnPassion: Bool = false
    @State var isOnCourage: Bool = false
    @State var isOnEndurance: Bool = false
    @State var isOnKindness: Bool = false
    @State var colorArray: [Color] = []
    
    
    var body: some View {
        return VStack {
            Spacer()
            VStack {
                Text(SettingConstants.introMessage)
            }
            .font(.system(size: SettingConstants.fontSize*1.4))
            .multilineTextAlignment(.center)
            
            Spacer()
            
            VStack(spacing: SettingConstants.fontSize*2.3) {
                HStack {
                    Spacer()
                    VerticalStatusView(imageView: Image(systemName: "flame.circle"),
                                       color: Color.red,
                                       value: SettingConstants.stringPassion,
                                       isSelected: $isOnPassion,
                                       colorArray: $colorArray)
                    Spacer()
                    VerticalStatusView(imageView: Image(systemName: "figure.wave.circle"),
                                       color: Color.green,
                                       value: SettingConstants.stringCourage,
                                       isSelected: $isOnCourage,
                                       colorArray: $colorArray)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    VerticalStatusView(imageView: Image(systemName: "hourglass.circle"),
                                       color: Color.blue,
                                       value: SettingConstants.stringEndurance,
                                       isSelected: $isOnEndurance,
                                       colorArray: $colorArray)
                    Spacer()
                    VerticalStatusView(imageView: Image(systemName: "heart.circle"),
                                       color: Color.hotPink,
                                       value: SettingConstants.stringKindness,
                                       isSelected: $isOnKindness,
                                       colorArray: $colorArray)
                    Spacer()
                }
            }
            .font(.system(size: SettingConstants.fontSize*1.6))
            
            Spacer()
            
            RoundedRectangle(cornerRadius: SettingConstants.fontSize*2)
                .fill(colorArray.isEmpty ?
                      LinearGradient(colors: [.gray], startPoint: .top, endPoint: .bottom) :
                        LinearGradient(gradient: Gradient(colors: colorArray), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .overlay(Text(SettingConstants.appNameForPromotion)
                            .font(.system(size: SettingConstants.fontSize*1.1, weight: Font.Weight.heavy, design: Font.Design.rounded))
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center))
                .frame(width: SettingConstants.fontSize*8,
                       height: SettingConstants.fontSize*1.7)
                .onTapGesture {
                    if !colorArray.isEmpty {
                        let value = Int(SettingConstants.startingStatus/colorArray.count)
                        if isOnPassion {
                            userStatus.passion = value
                        }
                        if isOnCourage {
                            userStatus.courage = value
                        }
                        if isOnEndurance {
                            userStatus.endurance = value
                        }
                        if isOnKindness {
                            userStatus.kindness = value
                        }
                        userStatus.setCurrentData()                        
                                                
                        let date = Calendar.current.startOfDay(for: Date())
                            .addingTimeInterval(SettingConstants.aDay * 1)
                        UserDefaults.tomorrow = date
                        UserDefaults.isFirstLaunched = false
                    }
                }
            Spacer()
        }
        .font(.system(size: SettingConstants.fontSize))
        
    }
}




