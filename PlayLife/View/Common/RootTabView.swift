//
//  RootTabView.swift
//  PlayLife
//
//  Created by MacAndys on 2021/12/21.
//

import SwiftUI



struct RootTabView: View {
    enum Tab: String {
        case tabOne
        case tabTwo
    }
    @State private var selection: Tab = .tabOne
    
    
    func setupTabBar() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = UIColor(named: "Color")
        
    }
    
    
    var body: some View {
        return TabView(selection: $selection) {
            NavigationView {
                TodayView()                    
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tag(Tab.tabOne)
            .tabItem {
                Image(systemName: "list.star")
            }
            
            
            PlayView()
                .tag(Tab.tabTwo)
                .tabItem {
                    Image(systemName: "dpad.up.filled")
                }
        }
        .onAppear {
            setupTabBar()
        }        
    }
}

struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView().environmentObject(UserStatus())
    }
}
