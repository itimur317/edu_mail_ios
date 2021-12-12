//
//  ImageDeleter.swift
//  Pickabook
//
//  Created by Timur on 12.12.2021.
//

import Foundation
import FirebaseStorage


protocol ImageDeleterProtocol : AnyObject {
    func deleteImages(URLs: [String]) -> Bool
}

final class ImageDeleter: ImageDeleterProtocol {
    
    private let storage = Storage.storage()

    init() {}
    
    func deleteImages(URLs: [String]) -> Bool {
        
        var count = 0
        
        for url in URLs {
            let storageRef = storage.reference(forURL: url)
            
            storageRef.delete { error in
                if let error = error {
                    print("images didn't deleted from DB\(error)")
                }
                else {
                    count += 1
                    print(count, "image deleted")
                }
            }
        }
        
        if count == URLs.count {
            return true
        }
        else {
            return false
        }
    }
}
