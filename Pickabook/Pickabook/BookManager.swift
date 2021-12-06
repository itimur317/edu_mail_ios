//
//  BookManager.swift
//  Pickabook
//
//  Created by Timur on 05.12.2021.
//

import Foundation
import FirebaseFirestore

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
    static let shared: BookManagerProtocol = BookManager()

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

//            let book = documents.compactMap { self?.bookConverter.book(from: $0) }
//            self?.output?.didRecieve(book)
        }
    }


    func create(book: Book) {
        database.collection("Books").addDocument(data: bookConverter.dict(from: book)) { [weak self] error in
            if let error = error {
                self?.output?.didFail(with: error)
            }
            else {
                self?.output?.didCreate(book)
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

//
//    func book(from document: DocumentSnapshot) -> Book? {
//        guard let dict = document.data(),
//              let identifier = dict[Key.identifier.rawValue] as? String,
//              let imageURLs = dict[Key.imageURLs.rawValue] as? [String?],
//              let name = dict[Key.name.rawValue] as? String,
//              let author = dict[Key.author.rawValue] as? String,
//              let genre = dict[Key.genre.rawValue] as? String,
//              let condition = dict[Key.condition.rawValue] as? Int,
//              let description = dict[Key.description.rawValue] as? String?,
//              let language = dict[Key.language.rawValue] as? String else {
//                  return nil
//              }
//
//
//        var currentBook = Book(identifier: identifier, bookImages: imageURLs, bookName: name, bookAuthor: author, bookGenres: Util.shared.genres[0], bookCondition: condition, bookDescription: description, bookLanguage: language)
//
//        if let index = Util.shared.genres.firstIndex(where: { $0.name == genre} ) {
//            currentBook.bookGenres = Util.shared.genres[index]
//        }
//
//        print(currentBook)
//        return currentBook
//    }


    func dict(from book: Book) -> [String : Any] {
        var dictBook : [String : Any]  = [:]
        
        ImageLoader.shared.uploadImage(imageData: book.bookImages[0]) { url in
            guard let url = url else { return }
            dictBook[Key.imageURLs.rawValue] = url
        }
        
        
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
