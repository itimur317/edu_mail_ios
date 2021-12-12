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

    func observeBooks(genreName : String)
    func create(book: Book)
}


protocol BookManagerOutput : AnyObject {
    func didRecieve(_ books: [Book])
    func didCreate(_ book: Book)
    func didFail(with error: Error)
    
}

enum DBError : Error {
    case unexpected
}

enum NetworkError : Error {
    case unexpected
}


final class BookManager : BookManagerProtocol {
    static var shared: BookManagerProtocol = BookManager()

    weak var output: BookManagerOutput?

    private let database = Firestore.firestore()

    private let bookConverter = BookConverter()

    func observeBooks(genreName : String) {
        DispatchQueue.global().async {
            self.database.collection("Books").whereField("genre", isEqualTo: genreName).addSnapshotListener { [weak self] querySnapshot, error in

                if let error = error {
                    print("error in observe")
                    self?.output?.didFail(with: error)
                    return
                }

                guard let documents = querySnapshot?.documents else {
                    print("query")
                    self?.output?.didFail(with: NetworkError.unexpected)
                    return
                }

                let books = documents.compactMap {
                        self?.bookConverter.book(from: $0)
                }
                self?.output?.didRecieve(books)
            }
            
            
        }
        
    }


    func create(book: Book) {

        let imageLoader: ImageLoaderProtocol = ImageLoader()
        
        imageLoader.uploadImage(imageData: book.bookImages) { [weak self] imageURLs in
            if book.bookImages.count == imageURLs.count {
                
                var dictForDatabase : [String : Any]
                
                dictForDatabase = ["identifier" : book.identifier!,
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

}
