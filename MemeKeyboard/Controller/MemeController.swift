//
//  MemeController.swift
//  MemeKeyboard
//
//  Created by Greg Hughes on 7/30/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit
import Photos

class MemeController {
    
    static let shared = MemeController()
    var memes : [Meme] = [] {
        didSet{
            print(memes)
        }
    }
    
    //create
    func createMeme(name: String?, image : UIImage){
        let newMeme = Meme(image: image, name: name)
        memes.insert(newMeme, at: 0)
    }
    
    func addMeme(meme: Meme){
        memes.append(meme)
    }
    
    //read
//    func fileURL() -> URL{
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let documentsDirectory = paths[0]
//        // array of the thing youre saving.json "entries.json"
//        let fileName = "memes.json"
//        let fullURL = documentsDirectory.appendingPathComponent(fileName)
//        // this adds a word to the file URL
//        print(fullURL)
//
//        return fullURL
//
//    }
//
//
//
//    func saveToPersistentStorage(){
//        let encoder = JSONEncoder()
//        do{
//            let data = try encoder.encode(<# self.entries #>)
//            try data.write(to: fileURL())
//        } catch{
//            print("There was an error in \(#function) \(error) : \(error.localizedDescription)")
//        }
//    }
//
//
//
//    func loadFromPersistentStorage() -> [<# Entry #>] {
//        let decoder = JSONDecoder()
//        do{
//            let data = try Data(contentsOf: fileURL())
//
//            let entries = try decoder.decode([<# Entry #>].self, from: data)
//            return entries
//        }catch{
//            print("There was an error in \(#function) \(error) : \(error.localizedDescription)")
//        }
//        return []
//    }
//    func fetchCustomAlbumPhotos()
//    {
//
//        let albumName = "Memes"
//        var assetCollection = PHAssetCollection()
//        var albumFound = Bool()
//        var photoAssets = PHFetchResult<AnyObject>()
//        let fetchOptions = PHFetchOptions()
//
//        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
//
//        let collection:PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
//
//        if let firstObject = collection.firstObject{
//            //found the album
//            assetCollection = firstObject
//            albumFound = true
//        }
//        else { albumFound = false }
//        _ = collection.count
//
//        photoAssets = PHAsset.fetchAssets(in: assetCollection, options: nil) as! PHFetchResult<AnyObject>
//
//        let imageManager = PHCachingImageManager()
//
//        photoAssets.enumerateObjects{(object: AnyObject!,
//            count: Int,
//            stop: UnsafeMutablePointer<ObjCBool>) in
//
//            if object is PHAsset{
//                let asset = object as! PHAsset
//                print("Inside  If object is PHAsset, This is number 1")
//
//                let imageSize = CGSize(width: asset.pixelWidth,
//                                       height: asset.pixelHeight)
//
//                /* For faster performance, and maybe degraded image */
//                let options = PHImageRequestOptions()
//                options.deliveryMode = .fastFormat
//                options.isSynchronous = true
//
//                imageManager.requestImage(for: asset,
//                                          targetSize: imageSize,
//                                          contentMode: .aspectFill,
//                                          options: options,
//                                          resultHandler: {
//                                            (image, info) -> Void in
//                                            /* The image is now available to us */
//                                            if image != nil {
//                                                self.addImgToArray(uploadImage: image!)
//                                            }
//
//
//                                            print("enum for image, This is number 2")
//
//                })
//            }
//        }
//    }
    
//    func addImgToArray(uploadImage:UIImage)
//    {
//        createMeme(name: nil, image: uploadImage)
//        
//    }
    
    //update
    
    //delete
    func deleteMeme(meme : Meme){
        
        for (index,i) in memes.enumerated() {
            if i == meme {
                memes.remove(at: index)
                break
            }
        }
    }
}
