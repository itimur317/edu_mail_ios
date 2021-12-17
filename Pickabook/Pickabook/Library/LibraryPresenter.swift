//
//  LibraryPresenter.swift
//  Pickabook
//
//  Created by Timur on 19.11.2021.
//

import Foundation
import FirebaseAuth

protocol LibraryPresenterProtocol : AnyObject {
    var currentBooks : [Book] { get set }
    func dismissView()
    func didTapOpenAddNewBook()
    func didTapOpenBook(book: Book)
    func observeBooks()
    func deleteBook(book: Book, index: Int)
}

final class LibraryPresenter : LibraryPresenterProtocol {
    
    weak var view : LibraryViewControllerProtocol?
    var currentBooks : [Book] = []
    private var deletedBook : Book? = nil
    
    func didTapOpenBook(book: Book) {
        self.view?.didTapOpenBook(book: book)
    }
    
    
    func dismissView() {
        self.view?.dismissView()
    }
    
    
    func didTapOpenAddNewBook() {
        print("opened AddNewBook")
        self.view?.didTapOpenAddNewBook()
        
    }
    
    func observeBooks() {
        DispatchQueue.global().async {
            BookManager.shared.output = self
            guard let MyId = Auth.auth().currentUser?.uid else {
                print("didn't registere")
                return}
            BookManager.shared.observeOwnerIdBooks(id: MyId)
        }
    }
    
    func deleteBook(book: Book, index: Int) {
        self.currentBooks.remove(at: index)
        self.deletedBook = book
        BookManager.shared.output = self
        BookManager.shared.delete(book: book)
    }
}


extension LibraryPresenter : BookManagerOutput {
    func didDelete(_ book: Book) {
        self.view?.successDeleteAlert()
    }
    
    func didRecieve(_ books: [Book]) {
        print("didRecieve in LibraryPresenter")
        currentBooks = books.sorted(by: { $0.bookName < $1.bookName })
        self.view?.reloadTable()
    }
    
    func didCreate(_ book: Book) {
        print("error didCreate in LibraryPresenter")
    }
    
    func didFail(with error: Error) {
        guard let deletedBook = self.deletedBook else {
            return
        }
        self.currentBooks.append(deletedBook)
        self.deletedBook = nil
        self.currentBooks.sort { $0.bookName < $1.bookName }
        self.view?.reloadTable()
        self.view?.errorAlert()
    }
}
