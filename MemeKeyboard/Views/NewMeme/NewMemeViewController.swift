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
    
    var newMemes: [Meme] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for _ in 1...10 {
            let newMeme = Meme(image: UIImage(named: "download")!, name: "")
            newMemes.append(newMeme)
        }
        
        
        
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
    
    @IBAction func doneAddingMemesButtonTapped(_ sender: Any) {
        #warning("save memes")
        
        let filteredMemes = newMemes.filter({$0.shouldUse == true})
        filteredMemes.forEach({MemeController.shared.addMeme(meme: $0)})
        print("❌\(CodableMemeController.shared.preparedCodableMemes)")
        CodableMemeController.shared.saveToPersistentStorage()
        self.dismiss(animated: true, completion: nil)
//        tableView.reloadData()

        
    }
    
    @IBAction func nevermindButtonTapped(_ sender: Any) {
        
    }
    
    
    

}
extension NewMemeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        
        
        return newMemes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newMemeCell", for: indexPath) as! NewMemeTableViewCell
        
        cell.delegate = self
        cell.newMeme = newMemes[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? NewMemeTableViewCell
        
        print(cell?.newMeme)
        
        
    }
}


extension NewMemeViewController: NewMemeCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    func dontAddButtonHit(cell: NewMemeTableViewCell) {
       
        cell.newMeme?.shouldUse.toggle()
        
//        cell.backgroundColor = cell.newMeme?.shouldUse == false ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 0.9707298802) : #colorLiteral(red: 0.2617847323, green: 0.7551102042, blue: 0.311136812, alpha: 1)
        
        cell.setDontAddButton()
        
    }
    
    
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
            
                
            currentCell.newMeme?.image = imageView.image!
            currentCell.newMeme?.shouldUse = true
            tableView.reloadData()
            
            let index = newMemes.firstIndex(of: currentCell.newMeme!)
            let indexPath = IndexPath(row: index!, section: 0)
            //        tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            
            print("🌸\(image.pngData())")
            tableView.reloadData()
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            
            
            
            
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
