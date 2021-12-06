//
//  BookManager.swift
//  Pickabook
//
//  Created by Timur on 05.12.2021.
//

import Foundation
import FirebaseFirestore
import UIKit

protocol BookManagerProtocol {
    var output: BookManagerOutput? { get set }

    func observeBooks()
    func create(book: Book)
}


protocol BookManagerOutput : AnyObject {
    func didRecieve(_ books: [Book])
    func didCreate(_ book: Book)
    func didFail(with error: Error)
    
}

enum NetworkError : Error {
    case unexpected
}


final class BookManager : BookManagerProtocol {
    static var shared: BookManagerProtocol = BookManager()

    weak var output: BookManagerOutput?

    private let database = Firestore.firestore()

    private let bookConverter = BookConverter()

    func observeBooks() {
        database.collection("Books").addSnapshotListener { [weak self] querySnapshot, error in

            if let error = error {
                self?.output?.didFail(with: error)
                return
            }

            guard let documents = querySnapshot?.documents else {
                self?.output?.didFail(with: NetworkError.unexpected)
                return
            }

            let books = documents.compactMap { self?.bookConverter.book(from: $0) }
            self?.output?.didRecieve(books)
        }
    }


    func create(book: Book) {
        
        // adding book without image
        let ref = database.collection("Books").addDocument(data: bookConverter.dict(from: book, db: database)) { [weak self] error in
            if let error = error {
                print("Error writing document: \(error)")
                self?.output?.didFail(with: error)
            }
            else {
                print("Document successfully written!")
            }
        }
        
        // adding images
        
        var imageURLs : [String] = []
        
        for i in 0..<book.bookImages.count {
            ImageLoader.shared.uploadImage(imageData: book.bookImages[i]) { [weak self] url in
                guard let url = url else { return }
                imageURLs += [url]
                
                self?.database.collection("Books").document(ref.documentID).setData(["imageURLs": imageURLs], merge: true) { err in
                    if let err = err {
                        print("Error writing images: \(err)")
                        if i == book.bookImages.count - 1 {
                            self?.output?.didFail(with: err)
                        }
                    } else {
                        print("Images successfully written!")
                        if i == book.bookImages.count - 1 {
                            self?.output?.didCreate(book)
                        }
                    }
                }
            }
        }
        

    }
    
    
   

}


private final class BookConverter {
    enum Key: String {
        case identifier
        case name
        case author
        case genre
        case condition
        case description
        case language
        case imageURLs
    }


    func book(from document: DocumentSnapshot) -> Book? {
        guard let dict = document.data(),
              let identifier = dict[Key.identifier.rawValue] as? String,
              let imageURLs = dict[Key.imageURLs.rawValue] as? [String],
              let name = dict[Key.name.rawValue] as? String,
              let author = dict[Key.author.rawValue] as? String,
              let genre = dict[Key.genre.rawValue] as? String,
              let condition = dict[Key.condition.rawValue] as? Int,
              let description = dict[Key.description.rawValue] as? String?,
              let language = dict[Key.language.rawValue] as? String else {
                  return nil
              }
        
        
        var imagesData : [Data] = []
        
        for i in 0..<imageURLs.count {
            guard let url = URL(string: imageURLs[i]) else { return nil }
                
            // как-то надо распараллелить
                if let data = try? Data(contentsOf: url) {
                        imagesData += [data]
                }
            }
        
        
        var currentBook = Book(identifier: identifier, bookImages: imagesData, bookName: name, bookAuthor: author, bookGenres: Util.shared.genres[0], bookCondition: condition, bookDescription: description, bookLanguage: language)

        if let index = Util.shared.genres.firstIndex(where: { $0.name == genre} ) {
            currentBook.bookGenres = Util.shared.genres[index]
        }

        print("вытащил \(currentBook)")
        return currentBook
    }


    func dict(from book: Book, db: Firestore) -> [String : Any] {
        var dictBook : [String : Any]  = [:]
        
        dictBook[Key.identifier.rawValue] = book.identifier
        dictBook[Key.name.rawValue] = book.bookName
        dictBook[Key.author.rawValue] = book.bookAuthor
        dictBook[Key.genre.rawValue] = book.bookGenres.name
        dictBook[Key.condition.rawValue] = book.bookCondition
        dictBook[Key.description.rawValue] = book.bookDescription
        dictBook[Key.language.rawValue] = book.bookLanguage
      
        return dictBook
    }
}
