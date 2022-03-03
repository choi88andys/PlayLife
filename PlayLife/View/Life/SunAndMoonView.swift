//
//  SunAndMoonView.swift
//  PlayLife
//
//  Created by MacAndys on 2021/12/29.
//

import SwiftUI


struct SunAndMoonView: View {
    @Binding var isSun: Bool
    @Binding var isMoon: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "sun.max")
                .foregroundColor(isSun ? Color.sunAndMoon : Color.gray)
                .onTapGesture {
                    if isMoon {
                        isSun.toggle()
                    }
                }
            
            Text("|")
                .foregroundColor(Color.gray)
            
            Image(systemName: "moon")
                .foregroundColor(isMoon ? Color.sunAndMoon : Color.gray)
                .onTapGesture {
                    if isSun {
                        isMoon.toggle()
                    }
                }
        }
        .padding(SettingConstants.fontSize*0.4)
        .overlay(
            RoundedRectangle(cornerRadius: SettingConstants.fontSize)
                .stroke(Color.gray, lineWidth: SettingConstants.fontSize*0.1))
    }
}


