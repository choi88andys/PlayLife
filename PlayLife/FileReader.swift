//
//  FileReader.swift
//  PlayLife
//
//  Created by MacAndys on 2022/01/08.
//

import UIKit
import SwiftUI

// var carData: [Car] = loadJson("carData.json")
// var nouns: [String] = loadTxt("noun.txt")

var nouns: [String] = loadTxt()


func loadTxt() {
    
    
    do {
        // This solution assumes  you've got the file in your bundle
        if let path = Bundle.main.path(forResource: "YourTextFilename", ofType: "txt"){
            let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
            nouns = data.components(separatedBy: "\n")
            print(nouns)
        }
    } catch let err as NSError {
        // do something with Error
        print(err)
    }

    
    
}


/*
func loadTxt<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else{
        fatalError("\(filename) not found")
    }
    
    do{
        data = try Data(contentsOf: file)
    }
    catch{
        fatalError("Could not load \(filename): (error)")
    }
    
    do{
        return try JSONDecoder().decode(T.self, from: data)
    }
    catch{
        fatalError("Unable parse \(filename): (error)")
    }
}
*/
