//
//  BooksCollectionViewPresenter.swift
//  Pickabook
//
//  Created by Ульяна Цимбалистая on 14.11.2021.
//

import Foundation
import UIKit

protocol BooksCollectionViewPresenterProtocol: AnyObject {
    func chosedBook(book: Book)
    var currentBooks : [Book] { get set }
    func observeBooks(genre: Genre)
    
}

final class BooksCollectionViewPresenter: BooksCollectionViewPresenterProtocol {
    weak var delegate : BooksCollectionViewController?
    var currentBooks : [Book] = []
    
    public func setViewDelegate(delegate: BooksCollectionViewController) {
        self.delegate = delegate
    }
    
    func observeBooks(genre: Genre) {
        BookManager.shared.output = self
        BookManager.shared.observeGenreBooks(genreName: genre.name)
    }
    
    func chosedBook(book: Book) {
        // открывает страницу книги
        delegate?.presentNextVC(selectedBook: book)
    }
}


extension BooksCollectionViewPresenter : BookManagerOutput {
    func didDelete(_ book: Book) {
        print("error")
    }
    
    func didRecieve(_ books: [Book]) {
        currentBooks = books.sorted(by: { $0.bookName < $1.bookName })
        self.delegate?.reloadCollection()
    }
    
    func didCreate(_ book: Book) {
        print("plohoCreate")
    }
    
    func didFail(with error: Error) {
        print("plohoFail")
    }
    
    
}
