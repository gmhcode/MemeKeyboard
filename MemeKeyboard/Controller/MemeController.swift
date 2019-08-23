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
    
    
    private init() {
      
        print("a")
        
    }
    
    /// never SET memes, only GET
    var memes : [Meme] = [] {
        didSet{
            print(memes)
            
        }
    }
    /// never GET from memesToAdd, only SET, memesToAdd filters out the copies already contained in memes, and converts memes to codable memes to be saved
    var memesToAdd : [Meme] = [] {
        didSet {
            
            let memesToAppend = filterMemes(memesToAdd: memesToAdd)
            
            let codableMemes = CodableMemeController.shared.convertMemesToCodable(memes: memesToAppend)
            
            CodableMemeController.codableMemes.append(contentsOf: codableMemes)
            
            memesToAdd = []
        }
    }
    /// this filters out the memes that are already in the memes array
    private func filterMemes(memesToAdd : [Meme]) -> [Meme]{
        
        var newMemes : [Meme] = []
        
        for i in memesToAdd {
            
            if memes.contains(i) == false {
                
                newMemes.append(i)
            }
        }
        memes.append(contentsOf: newMemes)
        
        //convert and add to codable memes
        
        return newMemes
    }
    
    
    
    //create
    func createMeme(name: String?, image : UIImage){
        let newMeme = Meme(image: image, name: name)
        memesToAdd.append(newMeme)
    }
    
    func addMeme(meme: Meme){
        memesToAdd.append(meme)
    }
    
    //read

    
    func convertCodableToMemes(codableMemes : [CodableMeme]) -> [Meme] {
        
        var newMemes : [Meme] = []
        
        for i in codableMemes {
            
            let newMeme = Meme(image: UIImage(data: i.imageData)!, name: i.name, uuid: i.uuid)
            
            newMeme.shouldUse = true
            
            newMemes.append(newMeme)
            
        }
        
        
        return newMemes
    }
    
    
    
    
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
