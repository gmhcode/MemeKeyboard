//
//  ViewController.swift
//  MemeKeyboard
//
//  Created by Greg Hughes on 7/30/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit
import Photos
class MainViewController: UIViewController {

    var memes = MemeController.shared.memes
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        memes = MemeController.shared.memes
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
//        textField.becomeFirstResponder()
    }
    
    func openCamera() {
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
    }
    
    func openPhotoLibrary() {
        
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("can't open photo library")
            return
        }
        
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addMemeButtonTapped(_ sender: Any) {
        
//        openPhotoLibrary()
        
    }
    
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
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
    }
    
}
extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            // imageViewPic.contentMode = .scaleToFill
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        defer {
            picker.dismiss(animated: true)
        }
        
        print("did cancel")
    }
}
