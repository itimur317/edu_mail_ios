//
//  ImageLoader.swift
//  Pickabook
//
//  Created by Timur on 05.12.2021.
//

import Foundation
import FirebaseStorage

protocol ImageLoaderProtocol: AnyObject {
    func uploadImage(imageData: Data, completion: @escaping (_ url: String?) -> Void)
    
}


final class ImageLoader: ImageLoaderProtocol {
    
    static let shared: ImageLoaderProtocol = ImageLoader()
    
    private let storageReference = Storage.storage().reference()
    
    private init() {}
    
    func uploadImage(imageData: Data, completion: @escaping (_ url: String?) -> Void) {
        

        let imageName = UUID().uuidString
        
        let storageRef = storageReference.child("\(imageName).jpeg")
        storageRef.putData(imageData, metadata: nil) { (metadata, error)  in
            if let _ = error {
                print("error putData")
                completion(nil)
            }
            else {
                storageRef.downloadURL { (url, error) in
                    print(url?.absoluteString)
                    completion(url?.absoluteString)
                }
            }
        }
        
        
        
    }
}
