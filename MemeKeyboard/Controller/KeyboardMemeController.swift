
//
//  File.swift
//  MemeKeyboard
//
//  Created by Greg Hughes on 8/1/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit
class KeyboardMemeController {
    
    static let shared = KeyboardMemeController()
    
    var memes : [Meme] = []
    
    private init(){
        
        let loadedMemes = loadFromPersistentStorage()
        
        memes = convertCodableToMemes(codableMemes: loadedMemes)
    }
    
    
    func fileURL() -> URL{
        let paths = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.greghughes.MemeKeyboard")
        //        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths
        // array of the thing youre saving.json "entries.json"
        let fileName = "preparedCodableMemes.json"
        let fullURL = documentsDirectory?.appendingPathComponent(fileName)
        // this adds a word to the file URL
        print(fullURL)
        
        return fullURL!
        
    }
    
    func loadFromPersistentStorage() -> [CodableMeme] {
        let decoder = JSONDecoder()
        do{
            let data = try Data(contentsOf: fileURL())
            
            let codableMemes = try decoder.decode([CodableMeme].self, from: data)
            return codableMemes
        }catch{
            print("There was an error in \(#function) \(error) : \(error.localizedDescription)")
        }
        return []
    }
    
    
    func convertCodableToMemes(codableMemes : [CodableMeme]) -> [Meme] {
        
        var newMemes : [Meme] = []
        
        for i in codableMemes {
            
            let newMeme = Meme(image: UIImage(data: i.imageData)!, name: i.name, uuid: i.uuid)
            
            newMeme.shouldUse = true
            
            newMemes.append(newMeme)
            
        }
        return newMemes
    }
}


