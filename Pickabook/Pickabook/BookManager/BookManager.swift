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
    
    func observeGenreBooks(genreName : String)
    func create(book: Book)
    func delete(book: Book)
}


protocol BookManagerOutput : AnyObject {
    func didRecieve(_ books: [Book])
    func didCreate(_ book: Book)
    func didFail(with error: Error)
    func didDelete(_ book: Book)
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
    
    func observeGenreBooks(genreName : String) {
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
    
    func delete(book: Book) {
        
        guard let id = book.identifier else {
            self.output?.didFail(with: DBError.unexpected)
            print("big error")
            return
        }
        self.database.collection("Books").whereField("identifier", isEqualTo: id).getDocuments { (snapshot, error) in
            if let error = error {
                self.output?.didFail(with: error)
                print("didn't find book\(error)")
            }
            else {
                for document in snapshot!.documents{
                    document.reference.delete { err in
                        if let err = err {
                            self.output?.didFail(with: err)
                            print("didn't delete\(err)")
                        }
                        else {
                            self.output?.didDelete(book)
                            print("book deleted in manager")
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
        case imageNames
        case imageURLs
    }
    
    
    func book(from document: DocumentSnapshot) -> Book? {
        guard let dict = document.data(),
              let identifier = dict[Key.identifier.rawValue] as? String,
              let imageURLs = dict[Key.imageURLs.rawValue] as? [String],
              let imageNames = dict[Key.imageNames.rawValue] as? [String],
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
        
        var currentBook = Book(identifier: identifier, bookImagesUrl: imageNames, bookImages: imagesData, bookName: name, bookAuthor: author, bookGenres: Util.shared.genres[0], bookCondition: condition, bookDescription: description, bookLanguage: language)
        
        if let index = Util.shared.genres.firstIndex(where: { $0.name == genre} ) {
            currentBook.bookGenres = Util.shared.genres[index]
        }
        
        print("вытащил \(currentBook)")
        return currentBook
    }
    
}
