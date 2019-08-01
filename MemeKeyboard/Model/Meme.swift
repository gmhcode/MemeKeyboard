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

//struct CodableMeme: Codable {
//    var image : UIImage
//var name : String?
//var uuid : String
//var shouldUse = false
//
//init(image : UIImage, name: String?, uuid : String = UUID().uuidString) {
//    self.image = image
//    self.name = name
//    self.uuid = uuid
//}
//}
