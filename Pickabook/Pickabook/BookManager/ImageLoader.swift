//
//  ImageLoader.swift
//  Pickabook
//
//  Created by Timur on 05.12.2021.
//

import Foundation
import FirebaseStorage
import UIKit

protocol ImageLoaderProtocol: AnyObject {
    func uploadImage(imageData: [Data], completion: @escaping (_ imageURLs: [String?],
                                                               _ imageNames: [String?]) -> Void)
    func getImage(with name: String, completion: @escaping (Result<Data, Error>) -> Void)
}


final class ImageLoader: ImageLoaderProtocol {
    
    //    static let shared: ImageLoaderProtocol = ImageLoader()
    
    private let storageReference = Storage.storage().reference()
    
    private var imageCache: [String:Data] = [:]
    
    init() {}
    
    func uploadImage(imageData: [Data], completion: @escaping (_ imageURLs: [String?],
                                                               _ imageNames: [String?]) -> Void) {
        
        var imageURLs = [String?](repeating: nil, count: imageData.count)
        var imageNames = [String?](repeating: nil, count: imageData.count)
        
        for i in 0..<imageData.count {
            
            let imageName = UUID().uuidString
            imageNames[i] = imageName
            
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
//                        print("url",i,"     ",  url?.absoluteString)
                        if url == nil {
                            return
                        }
                        imageNames[i] = imageName
                        imageURLs[i] = url?.absoluteString
                        if !imageURLs.contains(nil) {
                            completion(imageURLs, imageNames)
                        }
                    }
                }
            }
        }
        
    }
    
    
    func getImage(with name: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let name = "\(name).jpeg"
        
        if let data = imageCache[name] {
            completion(.success(data))
            return
        }
        
        storageReference.child(name).getData(maxSize: 15 * 1024 * 1024) { [weak self] (data, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                self?.imageCache[name] = data
                completion(.success(data))
            } else {
                completion(.failure(NetworkError.unexpected))
            }
        }
    }
}

