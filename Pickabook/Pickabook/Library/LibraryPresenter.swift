//
//  LibraryPresenter.swift
//  Pickabook
//
//  Created by Timur on 19.11.2021.
//

import Foundation

protocol LibraryPresenterProtocol : AnyObject {
    var currentBooks : [Book] { get set }
    func dismissView()
    func didTapOpenAddNewBook()
    func didTapOpenBook(book: Book)
    func observeBooks(genre: Genre)
    func deleteBook(book: Book, index: Int)
}

final class LibraryPresenter : LibraryPresenterProtocol {
    
    weak var view : LibraryViewControllerProtocol?
    var currentBooks : [Book] = []
    
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
    
    func observeBooks(genre: Genre) {
        DispatchQueue.global().async {
            BookManager.shared.output = self
            // сделать обсерв по профилю
            BookManager.shared.observeGenreBooks(genreName: "Фэнтези")
        }
    }
    
    func deleteBook(book: Book, index: Int) {
        self.currentBooks.remove(at: index)
        BookManager.shared.output = self
        BookManager.shared.delete(book: book)
    }
}


extension LibraryPresenter : BookManagerOutput {
    func didDelete(_ book: Book) {
        self.view?.successDeleteAlert()
    }
    
    func didRecieve(_ books: [Book]) {
        print("didRecieve in AddNewBook")
        currentBooks = books
        self.view?.reloadTable()
    }
    
    func didCreate(_ book: Book) {
        print("error didCreate in LibraryPresenter")
    }
    
    func didFail(with error: Error) {
        self.view?.errorAlert()
    }
}
