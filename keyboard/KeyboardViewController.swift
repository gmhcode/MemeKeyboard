//
//  KeyboardViewController.swift
//  keyboard
//
//  Created by Greg Hughes on 7/30/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    var proxy : UITextDocumentProxy!
    
    
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var buttonImage: UIButton!
    
    var keyboardView: UIView!
    var memes : [Meme]?

    
    @IBAction func imageButtonTest(_ sender: Any) {
        let paste = UIPasteboard.general
        
        var data = Data()
        
        do {
            
            data = try Data(contentsOf: URL(string: "https://images.pokemontcg.io/dp6/90.png")!)
            
            paste.setData(data, forPasteboardType: UIPasteboard.typeListImage[0] as! String)
            
        }catch{
            print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription)")
        }
    }
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInterface()
        collectionView.delegate = self
        collectionView.dataSource = self
        proxy = textDocumentProxy as UITextDocumentProxy
        nextKeyboardButton.addTarget(self, action: #selector(UIInputViewController.advanceToNextInputMode), for: .touchUpInside)
        
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    func loadInterface(){
        
        
        let keyboardNib = UINib(nibName: "keyboardStory", bundle: nil)
        keyboardView = keyboardNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        keyboardView.frame.size = view.frame.size
        
        let nibName = UINib(nibName: "CollectionViewCell", bundle:nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "collectionCell")
        
        view.addSubview(keyboardView)
        
        
    }
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    
    
    
    
    
    @IBAction func letterButtonsTapped(_ sender: Any) {
        
        guard let title = (sender as AnyObject).titleLabel?.text else {
            return
        }
        proxy.insertText(title)
        
    }
}
extension KeyboardViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        memes = KeyboardMemeController.shared.memes
    
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.2, height: collectionView.frame.height * 0.2)
    }
    
}


