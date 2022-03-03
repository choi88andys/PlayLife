//
//  PlayLifeApp.swift
//  PlayLife
//
//  Created by MacAndys on 2021/12/21.
//

import SwiftUI
import UIKit


@main
struct PlayLifeApp: App {
    @StateObject private var dataController = DataController()
    @StateObject var userStatus = UserStatus.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userStatus)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

