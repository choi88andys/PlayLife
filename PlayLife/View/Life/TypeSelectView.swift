//
//  TypeSelectView.swift
//  PlayLife
//
//  Created by MacAndys on 2022/01/12.
//

import SwiftUI

struct TypeSelectView: View {
    @Binding var typeSelection: ItemType
    
    var body: some View {
        return HStack(spacing: SettingConstants.fontSize * 0.2) {
            if typeSelection == .once {
                SelectedTypeImageView(typeSelection: typeSelection)
            } else {
                TypeImageView(typeSelection: $typeSelection,
                              name: "1.square",
                              type: .once)
            }
            
            
            if typeSelection == .daysOfWeek {
                SelectedTypeImageView(typeSelection: typeSelection)
            } else {
                TypeImageView(typeSelection: $typeSelection,
                              name: "7.square",
                              type: .daysOfWeek)
            }
            
            
            if typeSelection == .daysOfMonth {
                SelectedTypeImageView(typeSelection: typeSelection)
            } else {
                TypeImageView(typeSelection: $typeSelection,
                              name: "31.square",
                              type: .daysOfMonth)
            }
        }
        .font(.system(size: SettingConstants.fontSize*2.25))
    }
}


struct TypeImageView: View {
    @Binding var typeSelection: ItemType
    var name: String
    var type: ItemType
    
    var body: some View {
        Image(systemName: name)
            .foregroundColor(Color.typeSelection)
            .onTapGesture {
                withAnimation(
                    .linear(duration: SettingConstants.typeChangeDuration)) {
                        typeSelection = type
                    }
            }
    }
}


struct SelectedTypeImageView: View {
    var typeSelection: ItemType
    
    var body: some View {
        Group {
            if typeSelection == .once {
                Image(systemName: "1.square.fill")
            } else if typeSelection == .daysOfWeek {
                Image(systemName: "7.square.fill")
            }
            else if typeSelection == .daysOfMonth {
                Image(systemName: "31.square.fill")
            }
        }
        .foregroundColor(Color.typeSelection)
    }
}


