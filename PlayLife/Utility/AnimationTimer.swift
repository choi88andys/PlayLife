//
//  SwiftUIView.swift
//  PlayLife
//
//  Created by MacAndys on 2022/01/29.
//

import Foundation
import SwiftUI

class AnimationTimer: ObservableObject{
    @Published var timer: Timer?
    @Published var isShowingResultRefresher: Bool = false
    @Published var animateDuration: Double = 0
        
    init(){
        timer = Timer.scheduledTimer(timeInterval: SettingConstants.timerInterval,
                                     target: self,
                                     selector: #selector(timeDidFire),
                                     userInfo: nil,
                                     repeats: true)
        timer?.tolerance = SettingConstants.timerInterval * 0.1
    }
    
    
    
    @objc func timeDidFire(){
        if animateDuration > 0 {
            animateDuration -= SettingConstants.timerInterval
            
            if animateDuration <= 0 {
                withAnimation {
                    isShowingResultRefresher = true
                }
            }
        }
    }
    
}
