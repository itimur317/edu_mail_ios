//
//  ImageDeleter.swift
//  Pickabook
//
//  Created by Timur on 12.12.2021.
//

import Foundation
import FirebaseStorage


protocol ImageDeleterProtocol : AnyObject {
    func deleteImages(imageNames : [String]) -> Bool
    
}

final class ImageDeleter: ImageDeleterProtocol {
    
    private let storageReference = Storage.storage().reference()
    
    init() {}
    
    func deleteImages(imageNames : [String]) -> Bool {
        
        var count = 0
        
        for name in imageNames {
            storageReference.child("\(name).jpeg").delete { error in
                if let error = error {
                    BookManager.shared.output?.didFail(with: error)
                    print("error in deleting images\(error)")
                }
                else {
                    count += 1
                    print(count, "image deleted")
                }
            }
        }
        return true
    }
}
