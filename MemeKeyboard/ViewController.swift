//
//  ViewController.swift
//  MemeKeyboard
//
//  Created by Greg Hughes on 7/30/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let memes = MemeController.shared.memes
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
//        textField.becomeFirstResponder()
    }


}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("🐯\(MemeController.shared.memes.count)")
        return MemeController.shared.memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCell", for: indexPath) as! MemeCollectionViewCell
        
        cell.meme = MemeController.shared.memes[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("blah")
        collectionView.reloadData()
        MemeController.shared.fetchCustomAlbumPhotos()
    }
    
}
