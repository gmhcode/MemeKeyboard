//
//  CodableMeme.swift
//  MemeKeyboard
//
//  Created by Greg Hughes on 8/1/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit

struct CodableMeme: Codable {
    var imageData : Data
    var name : String?
    var uuid : String
    var shouldUse = true
    
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
