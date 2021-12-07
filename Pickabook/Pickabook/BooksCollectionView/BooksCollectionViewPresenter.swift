//
//  BooksCollectionViewPresenter.swift
//  Pickabook
//
//  Created by Ульяна Цимбалистая on 14.11.2021.
//

import Foundation
import UIKit

protocol BooksCollectionViewPresenterProtocol: AnyObject {
    func loadBooks(genre: Genre) -> [Book]
    func chosedBook(book: Book)
    var currentBooks : [Book] { get set }
    func observeBooks()
}

final class BooksCollectionViewPresenter: BooksCollectionViewPresenterProtocol {
    weak var delegate : BooksCollectionViewController?
    var currentBooks : [Book] = []

    
    public func setViewDelegate(delegate: BooksCollectionViewController) {
        self.delegate = delegate
    }
    
    func observeBooks() {
        BookManager.shared.output = self
        BookManager.shared.observeBooks()
    }
    
    func chosedBook(book: Book) {
        // открывает страницу книги
        delegate?.presentNextVC(selectedBook: book)
    }
    
    func loadBooks(genre: Genre) -> [Book] {
        // здесь будет загрузка книг из бд
        
        let sortedBooks = books.filter({ $0.bookGenres.type == genre.type })
        return sortedBooks
    }
}


extension BooksCollectionViewPresenter :BookManagerOutput {
    func didRecieve(_ books: [Book]) {
        currentBooks = books
        self.delegate?.reloadCollection()
    }
    
    func didCreate(_ book: Book) {
        print("plohoCreate")
    }
    
    func didFail(with error: Error) {
        print("plohoFail")
    }
    
    
}
