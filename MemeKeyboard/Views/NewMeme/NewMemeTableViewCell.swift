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
    func dontAddButtonHit(cell: NewMemeTableViewCell)
}


class NewMemeTableViewCell: UITableViewCell {

    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var dontAddButton: UIButton!
    
    weak var delegate : NewMemeCellDelegate?
    
    
    var newMeme : Meme? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    func updateViews(){
        imageButton.setImage(newMeme!.image, for: .normal)
        
        setDontAddButton()
        
        
        
        
    }
    
    func setDontAddButton(){
        if newMeme?.shouldUse == false {
            dontAddButton.setTitle("Will Add", for: .normal)
            dontAddButton.backgroundColor = #colorLiteral(red: 0.2617847323, green: 0.7551102042, blue: 0.311136812, alpha: 1)
            self.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 0.9707298802)
        } else {
            dontAddButton.setTitle("Dont Add", for: .normal)
            dontAddButton.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 0.9707298802)
            self.backgroundColor = #colorLiteral(red: 0.2617847323, green: 0.7551102042, blue: 0.311136812, alpha: 1)
        } 
    }
    
    
    
    
    @IBAction func imageButtonTapped(_ sender: Any) {
        
        delegate?.newMemeSelected(cell: self)
    }
    @IBAction func dontAddButtonTapped(_ sender: Any) {
        delegate?.dontAddButtonHit(cell: self)
    }
    
    

}
extension NewMemeTableViewCell {
    override func prepareForReuse() {
         imageButton.setImage(UIImage(named: "download"), for: .normal)
        
    }
}
