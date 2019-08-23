//
//  ReloadData.swift
//  MemeKeyboard
//
//  Created by Greg Hughes on 8/22/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit


protocol ReloadDelegate: class {
    func reload()
}

class ReloadData{
    
    weak var delegate : ReloadDelegate?
    static var shared = ReloadData()
    
    static func reloadCollectionView(){
        ReloadData.shared.delegate?.reload()
    }   
}
