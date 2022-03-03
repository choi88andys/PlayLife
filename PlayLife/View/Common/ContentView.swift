//
//  ContentView.swift
//  PlayLife
//
//  Created by MacAndys on 2021/12/21.
//

import SwiftUI

struct ContentView: View {
    let isFirstLaunched = UserDefaults.isFirstLaunched
    
    var body: some View {
        return Group {
            if isFirstLaunched {
                PersonalityView()
            }
            else {
                RootTabView()
            }
        }
    }
    
    
}

