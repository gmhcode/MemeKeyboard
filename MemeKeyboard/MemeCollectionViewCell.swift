//
//  MemeCollectionViewCell.swift
//  MemeKeyboard
//
//  Created by Greg Hughes on 7/30/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var memeImage: UIImageView!
    
    var meme : Meme? {
        didSet {
            memeImage.image = meme?.image
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
        
    }
    
    
    
}
