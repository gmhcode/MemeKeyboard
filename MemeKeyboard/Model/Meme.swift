//
//  Meme.swift
//  MemeKeyboard
//
//  Created by Greg Hughes on 7/30/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit

class Meme {
    
    var image : UIImage
    var name : String?
    var uuid : String
    var shouldUse = false
    
    init(image : UIImage, name: String?, uuid : String = UUID().uuidString) {
        self.image = image
        self.name = name
        self.uuid = uuid
    }
}
extension Meme: Equatable {
    static func == (lhs: Meme, rhs: Meme) -> Bool {
        
        return lhs.image == rhs.image && lhs.uuid == rhs.uuid && lhs.name == rhs.name
    }
}

struct CodableMeme: Codable {
    var imageData : Data
    var name : String?
    var uuid : String
    var shouldUse = false

init(imageData : Data, name: String?, uuid : String = UUID().uuidString) {
    self.imageData = imageData
    self.name = name
    self.uuid = uuid
 }
}
extension CodableMeme: Equatable {
    static func == (lhs: CodableMeme, rhs: CodableMeme) -> Bool {
        
        return lhs.imageData == rhs.imageData && lhs.uuid == rhs.uuid && lhs.name == rhs.name
    }
}

class CodableMemeController {
    
    
    static let shared = CodableMemeController()
    
    
    var preparedCodableMemes : [CodableMeme] = []
    
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
    
    
    
    func convertMemesToCodable(memes: [Meme] ) -> [CodableMeme] {
        
        var newCodableMemes : [CodableMeme] = []
        
        for i in memes {
            
            var newCodableMeme = CodableMeme(imageData: i.image.pngData()!, name: i.name, uuid: i.uuid)
            
            newCodableMemes.append(newCodableMeme)
        }
        
        
        
        return newCodableMemes
    }
    
    
        func fileURL() -> URL{
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentsDirectory = paths[0]
            // array of the thing youre saving.json "entries.json"
            let fileName = "preparedCodableMemes.json"
            let fullURL = documentsDirectory.appendingPathComponent(fileName)
            // this adds a word to the file URL
            print(fullURL)
    
            return fullURL
    
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
                CodableMemeController.codableMemes.append(contentsOf: codableMemes)
                return codableMemes
            }catch{
                print("There was an error in \(#function) \(error) : \(error.localizedDescription)")
            }
            return []
        }
    
    
    
    
    
}
