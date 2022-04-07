//
//  StatusView.swift
//  PlayLife
//
//  Created by MacAndys on 2021/12/23.
//

import SwiftUI



struct StatusView: View {
    var spacing: Double = SettingConstants.fontSize*0.045
    let imageView: Image
    let color: Color
    let value: String
    var fontName: String = ""
    var fontSize: Double = SettingConstants.fontSize * 1.2
    var isTalent: Bool = false
    
    var body: some View {
        return HStack(spacing: spacing){
            if isTalent {
                Spacer()
            }
            
            imageView.foregroundColor(color)
                .font(.system(size: SettingConstants.fontSize * 1.2))
            Text(value).lineLimit(1)
                .font(.custom(fontName, size: fontSize))
            
            if !isTalent {
                Spacer()
            }
        }
    }
}


struct VerticalStatusView: View {
    var spacing: Double = SettingConstants.fontSize*0.2
    let imageView: Image
    let color: Color
    let value: String
    
    @Binding var isSelected: Bool
    @Binding var colorArray: [Color]
        
    var body: some View {
        return VStack(spacing: spacing){
            imageView
                .foregroundColor(isSelected ? color : Color.gray)
                .font(.system(size: SettingConstants.fontSize*1.7))
            Text(value)
                .font(.system(size: SettingConstants.fontSize))
        }
        .frame(width: SettingConstants.isEnglish ? SettingConstants.fontSize*7 : SettingConstants.fontSize*4.5,
               height: SettingConstants.isEnglish ? SettingConstants.fontSize*7 : SettingConstants.fontSize*5.5)
        .overlay(
            RoundedRectangle(cornerRadius: SettingConstants.fontSize*1.3)
                .stroke(Color.gray, lineWidth: 1.8)
        )
        .onTapGesture {
            isSelected.toggle()
            if isSelected {
                colorArray.append(color)
            }
            else {
                colorArray = colorArray.filter() {
                    $0 != color
                }
            }
        }
        
    }
}



