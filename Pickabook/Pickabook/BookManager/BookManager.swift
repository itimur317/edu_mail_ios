//
//  BookManager.swift
//  Pickabook
//
//  Created by Timur on 05.12.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import UIKit

protocol BookManagerProtocol {
    var output: BookManagerOutput? { get set }
    func observeOwnerIdBooks(id : String)
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


    private var books : [Book] = []
    
    let imageLoader: ImageLoaderProtocol = ImageLoader()
    
    func observeOwnerIdBooks(id: String) {
        self.database.collection("Books").whereField("ownerId", isEqualTo: id).addSnapshotListener { [weak self] querySnapshot, error in
            
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
            
            var books = documents.compactMap {
                self?.bookConverter.book(from: $0)
            }
            self?.output?.didRecieve(books)
            
            self?.books = books
            
            for j in 0..<books.count {
                guard let names = books[j].bookImagesNamesDB else {return}
                for i in 0..<names.count {
                    self?.imageLoader.getImage(with: names[i]) { [weak self] (result) in
                        switch result {
                        case .success(let data):
//                            books[j].bookImages.append(data)
                            if i == 0 {
                                books[j].bookImages.insert(data, at: 0)
                            } else if i == 1 {
                                if books[j].bookImages.count == 0 {
                                    books[j].bookImages.insert(data, at: 0)
                                } else {
                                    books[j].bookImages.insert(data, at: 1)
                                }
                            } else {
                                if books[j].bookImages.count == 0 {
                                    books[j].bookImages.insert(data, at: 0)
                                } else if books[j].bookImages.count == 1 {
                                    books[j].bookImages.insert(data, at: 1)
                                } else {
                                    books[j].bookImages.insert(data, at: 2)
                                }
                            }
//                            books[j].bookImages.insert(data, at: i)
                            self?.output?.didRecieve(books)
                            print(books[j].bookImages)
                        case .failure(let error):
                            print(error)
                        }
                    }

                }
            }
  
        }
    }
    
    func observeGenreBooks(genreName : String) {
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
            
            var books = documents.compactMap {
                self?.bookConverter.book(from: $0)
            }
            self?.output?.didRecieve(books)
            
            self?.books = books
            
            for j in 0..<books.count {
                guard let names = books[j].bookImagesNamesDB else {return}
                for i in 0..<names.count {
                    self?.imageLoader.getImage(with: names[i]) { [weak self] (result) in
                        switch result {
                        case .success(let data):
//                            books[j].bookImages.append(data)
                            if i == 0 {
                                books[j].bookImages.insert(data, at: 0)
                            } else if i == 1 {
                                if books[j].bookImages.count == 0 {
                                    books[j].bookImages.insert(data, at: 0)
                                } else {
                                    books[j].bookImages.insert(data, at: 1)
                                }
                            } else {
                                if books[j].bookImages.count == 0 {
                                    books[j].bookImages.insert(data, at: 0)
                                } else if books[j].bookImages.count == 1 {
                                    books[j].bookImages.insert(data, at: 1)
                                } else {
                                    books[j].bookImages.insert(data, at: 2)
                                }
                            }
//                            books[j].bookImages.insert(data, at: i)
                            self?.output?.didRecieve(books)
                            print(books[j].bookImages)
                        case .failure(let error):
                            print(error)
                        }
                    }

                }
            }
  
        }
    }
    
    func create(book: Book) {
        
        let imageLoader: ImageLoaderProtocol = ImageLoader()
        
        imageLoader.uploadImage(imageData: book.bookImages) { [weak self] imageURLs, imageNames in
            if book.bookImages.count == imageURLs.count {
                
                var dictForDatabase : [String : Any]
                
                guard let currentUserId = Auth.auth().currentUser?.uid else {
                    print("didn't register")
                    return
                }
                
                dictForDatabase = ["identifier" : book.identifier!,
                                   "ownerId" : currentUserId,
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
                let imageDeleter : ImageDeleterProtocol = ImageDeleter()
                for document in snapshot!.documents{
                    document.reference.delete { err in
                        if let err = err {
                            self.output?.didFail(with: err)
                            print("didn't delete\(err)")
                        }
                        else {
                            guard let images = book.bookImagesNamesDB else {
                                self.output?.didFail(with: DBError.unexpected)
                                return
                            }
                            if imageDeleter.deleteImages(imageNames: images) {
                                self.output?.didDelete(book)
                                print("book deleted in manager")
                            }
                            else {
                                self.output?.didFail(with: DBError.unexpected)
                                print("didn't deleted")
                            }
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
        case ownerId
        case name
        case author
        case genre
        case condition
        case description
        case language
        case imageNames
        case imageURLs
    }


//    let imageLoader: ImageLoaderProtocol = ImageLoader()
    
//    var imagesData: [Data] = []



    func book(from document: DocumentSnapshot) -> Book? {
        
        guard let dict = document.data(),
              let identifier = dict[Key.identifier.rawValue] as? String,
              let ownerId = dict[Key.ownerId.rawValue] as? String,
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
        
        
        

//       
        
//        for i in 0..<imageURLs.count {
//            guard let url = URL(string: imageURLs[i]) else { return nil }
//                if let data = try? Data(contentsOf: url) {
//                        imagesData += [data]
//                }
//        }
        
        
        
        
        var currentBook = Book(identifier: identifier,ownerId: ownerId, bookImagesNamesDB: imageNames, bookImages: [], bookName: name, bookAuthor: author, bookGenres: Util.shared.genres[0], bookCondition: condition, bookDescription: description, bookLanguage: language)


        if let index = Util.shared.genres.firstIndex(where: { $0.name == genre} ) {
            currentBook.bookGenres = Util.shared.genres[index]
        }
        
        print("вытащил \(currentBook)")
        return currentBook
    }
    
}
