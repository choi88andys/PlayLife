//
//  DataController.swift
//  PlayLife
//
//  Created by MacAndys on 2021/12/24.
//




import SwiftUI
import CoreData


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "PlayLife")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }

            
            // self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
