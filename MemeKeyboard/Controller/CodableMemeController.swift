//
//  CodableMemeController.swift
//  MemeKeyboard
//
//  Created by Greg Hughes on 8/1/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit
class CodableMemeController {
    
    
    static let shared = CodableMemeController()
    
    ///never Set preparedCodableMemes, only GET
    var preparedCodableMemes : [CodableMeme] = []
    
    ///never GET codableMemes outside of the filterMemesFunction, only SET
    static var codableMemes : [CodableMeme] = [] {
        didSet {
            
            CodableMemeController.shared.filterMemes(codableMemes: codableMemes)
            codableMemes = []
            
        }
    }
    
    
    //TODO: - Put this in the add to memes Button in NewMemeViewController
    private func filterMemes(codableMemes : [CodableMeme]){
        
        for i in codableMemes{
            
            if preparedCodableMemes.contains(i) == false {
                
                preparedCodableMemes.append(i)
                
            }
        }
    }
    
    
    // update notes
    func convertMemesToCodable(memes: [Meme] ) -> [CodableMeme] {
        
        var newCodableMemes : [CodableMeme] = []
        
        for i in memes {
            
            var newCodableMeme = CodableMeme(imageData: i.image.pngData()!, name: i.name, uuid: i.uuid)
            
            newCodableMemes.append(newCodableMeme)
        }
        
        
        //fix this
        return newCodableMemes
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
    
    
    
    func saveToPersistentStorage(){
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(preparedCodableMemes)
            try data.write(to: fileURL())
        } catch{
            print("There was an error in \(#function) \(error) : \(error.localizedDescription)")
        }
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
    
    
    
    
}
