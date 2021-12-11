//
//  ImageLoader.swift
//  Pickabook
//
//  Created by Timur on 05.12.2021.
//

import Foundation
import FirebaseStorage

protocol ImageLoaderProtocol: AnyObject {
    func uploadImage(imageData: [Data], completion: @escaping (_ imageURLs: [String?]) -> Void)
    
}


final class ImageLoader: ImageLoaderProtocol {
    
    static let shared: ImageLoaderProtocol = ImageLoader()
    
    private let storageReference = Storage.storage().reference()
    
    private init() {}
    
    func uploadImage(imageData: [Data], completion: @escaping (_ imageURLs: [String?]) -> Void) {
        
        var imageURLs : [String?] = []

        for i in 0..<imageData.count {
            
            let imageName = UUID().uuidString
            
            let storageRef = storageReference.child("\(imageName).jpeg")
            storageRef.putData(imageData[i], metadata: nil) { (metadata, error)  in
                if let _ = error {
                    print("error putData")
                    completion([nil])
                }
                else {
                    storageRef.downloadURL { (url, error) in
                        print(url?.absoluteString)
                        imageURLs += [url?.absoluteString]
                        if imageData.count == imageURLs.count {
                            completion(imageURLs)
                        }
                    }
                }
            }
            
        }
        
        
        
        
    }
}
