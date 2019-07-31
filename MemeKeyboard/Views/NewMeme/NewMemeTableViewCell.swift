//
//  NewMemeTableViewCell.swift
//  MemeKeyboard
//
//  Created by Greg Hughes on 7/31/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit

protocol NewMemeCellDelegate:class {
    func newMemeSelected(cell: NewMemeTableViewCell)
}


class NewMemeTableViewCell: UITableViewCell {

    @IBOutlet weak var imageButton: UIButton!
    
    weak var delegate : NewMemeCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews(){
        
    }
    
    
    
    
    
    @IBAction func imageButtonTapped(_ sender: Any) {
        
        
        delegate?.newMemeSelected(cell: self)
    }
    
    

}

