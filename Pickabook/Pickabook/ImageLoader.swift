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
    
//    static let shared: ImageLoaderProtocol = ImageLoader()
    
    private let storageReference = Storage.storage().reference()
    
    init() {}
    
    func uploadImage(imageData: [Data], completion: @escaping (_ imageURLs: [String?]) -> Void) {
        
        var imageURLs = [String?](repeating: nil, count: imageData.count)
        var imageNames = [String?](repeating: nil, count: imageData.count)
        
        for i in 0..<imageData.count {
            
            let imageName = UUID().uuidString
            
            print(imageData)
            let storageRef = storageReference.child("\(imageName).jpeg")
            storageRef.putData(imageData[i], metadata: nil) { (metadata, error)  in
                if let error = error {
                    print("error putData")
                    imageURLs = [String?](repeating: nil, count: imageData.count)
                    BookManager.shared.output?.didFail(with: error)
                    return
                }
                else {
                    storageRef.downloadURL { (url, error) in
                        print("url",i,"     ",  url?.absoluteString)
                        if url == nil {
                            return
                        }
                        imageNames[i] = imageName
                        imageURLs[i] = url?.absoluteString
                        if !imageURLs.contains(nil) {
                            completion(imageURLs)
                        }
                    }
                }
            }
        }
        
    }
}

protocol ImageDeleterProtocol : AnyObject {
    func deleteImage(url: String)
}

final class ImageDeleter: ImageDeleterProtocol {
    func deleteImage(url: String) {
//        <#code#>
    }
    
    
}
