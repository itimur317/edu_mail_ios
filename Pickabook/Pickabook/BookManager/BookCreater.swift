//
//  BookCreater.swift
//  Pickabook
//
//  Created by Timur on 13.12.2021.
//

import Foundation
import FirebaseFirestore
import UIKit

protocol BookCreaterProtocol : AnyObject {
    var output: BookCreaterOutput? { get set }

    func create(book: Book)
}

protocol BookCreaterOutput : AnyObject {
    func didCreate(_ book: Book)
    func didFail(with error: Error)
}

final class BookCreater : BookCreaterProtocol {
    
    static var shared: BookCreaterProtocol = BookCreater()

    weak var output: BookCreaterOutput?

    private let database = Firestore.firestore()
    
    func create(book: Book) {
        let imageLoader: ImageLoaderProtocol = ImageLoader()
        
        imageLoader.uploadImage(imageData: book.bookImages) { [weak self] imageURLs, imageNames in
            if book.bookImages.count == imageURLs.count {
                
                var dictForDatabase : [String : Any]
                
                dictForDatabase = ["identifier" : book.identifier!,
                                   "imageNames" : imageNames,
                                   "imageURLs" : imageURLs,
                                   "name" : book.bookName,
                                   "author" : book.bookAuthor,
                                   "genre" : book.bookGenres.name,
                                   "condition" : book.bookCondition,
                                   "language" : book.bookLanguage]
                
                if book.bookDescription != nil {
                    dictForDatabase["description"] = book.bookDescription!
                }
                
                self?.database.collection("Books").addDocument(data: dictForDatabase) { [weak self] error in
                    if let error = error {
                        print("Error writing document: \(error)")
                        self?.output?.didFail(with: error)
                    }
                    else {
                        print("Document successfully written!")
                        self?.output?.didCreate(book)
                    }
                }
            } else { return }
        }
    }

}
