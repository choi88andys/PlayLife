//
//  View+customModifier.swift
//  PlayLife
//
//  Created by MacAndys on 2022/01/07.
//

import SwiftUI


extension View {
    func customStyle(innerPadding: CGFloat = SettingConstants.fontSize*0.6) -> some View {
        self
            .frame(width: UIScreen.main.bounds.size.width*0.9, alignment: .leading)
            .padding(innerPadding)
            .overlay(
                RoundedRectangle(cornerRadius: SettingConstants.fontSize * 1.1)
                    .stroke(Color.gray))
            .padding(SettingConstants.edgePadding)
    }
    
    
    func todayItemStyle(isDone: Bool) -> some View {
        self
            .font(.system(size: SettingConstants.fontSize))
            .opacity(isDone ? SettingConstants.doneItemOpacity : 1)
            .padding(.vertical, SettingConstants.fontSize*0.8)
            .padding(.horizontal, SettingConstants.fontSize*0.9)
            .overlay(RoundedRectangle(cornerRadius: SettingConstants.fontSize*1.2)
                        .stroke(isDone ? Color.systemGray3 : Color.systemGray,
                                lineWidth: SettingConstants.overlayLineWidth)
            )
            .background(RoundedRectangle(cornerRadius: SettingConstants.fontSize*1.2)
                            .fill(isDone ? Color.systemGray6 : Color.systemGray5)
                            .shadow(color: isDone ? Color.systemGray3 : Color.systemGray,
                                    radius: SettingConstants.shadowRadius,
                                    x: 0, y: SettingConstants.shadowY)
            )
            .padding(.horizontal, SettingConstants.fontSize*0.7)
            .padding(.vertical, SettingConstants.fontSize*0.35)
    }
            
}



extension Circle {
    func customCircle(text: String, color: Color, isSelected: Bool) -> some View {
        self
            .strokeBorder(color, lineWidth: SettingConstants.fontSize*0.15)
            .background(Circle().foregroundColor(isSelected ? color : Color.background))
            .overlay(Text(text)
                        .font(.system(size: SettingConstants.fontSize*1.2,
                                      weight: isSelected ? .black : .medium))
                        .foregroundColor(isSelected ? Color.background : color)
                        .multilineTextAlignment(.center))
            .frame(width: SettingConstants.fontSize*2.1, height: SettingConstants.fontSize*2.1)
    }
}





