//
//  SwiftUIView.swift
//  PlayLife
//
//  Created by MacAndys on 2022/01/29.
//

import SwiftUI



struct ShowingStarView: View {
    let transition = AnyTransition
        .opacity
        .combined(with: .offset(y: SettingConstants.fontSize * -1.9))
    var body: some View {
        HStack(spacing: 0){
            Text("+")
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
        }
        .font(.system(size: SettingConstants.fontSize))
        .padding(.top, SettingConstants.fontSize*0.4)
        .transition(transition)
    }
}
