//
//  NewMemeViewController.swift
//  MemeKeyboard
//
//  Created by Greg Hughes on 7/31/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit
import Photos
class NewMemeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let imagePicker = UIImagePickerController()
    var currentCell = NewMemeTableViewCell()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        imagePicker.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension NewMemeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newMemeCell", for: indexPath) as! NewMemeTableViewCell
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height * 0.80
    }
    
    
}

extension NewMemeViewController: NewMemeCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    
    
    func newMemeSelected(cell: NewMemeTableViewCell) {
        currentCell = cell
        openPhotoLibrary()
        

    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            // imageViewPic.contentMode = .scaleToFill
            let imageView = UIImageView(frame: currentCell.imageButton.frame )
            let image = pickedImage
            imageView.image = image
            currentCell.imageButton.imageView?.contentMode = .scaleAspectFill
            
            currentCell.imageButton.setImage(imageView.image, for: .normal)
//            tableView.reloadData()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        defer {
            picker.dismiss(animated: true)
        }
        
        print("did cancel")
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
    
}
