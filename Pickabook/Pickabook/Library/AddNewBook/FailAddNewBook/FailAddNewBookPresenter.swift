//
//  FailAddNewBook.swift
//  Pickabook
//
//  Created by Timur on 19.11.2021.
//

import Foundation

protocol FailAddNewBookPresenterProtocol : AnyObject {
    var book: Book { get set }

    func didTapTryAgainButton()
    func didTapQuitButton()
}

final class FailAddNewBookPresenter : FailAddNewBookPresenterProtocol, BookManagerOutput {
    func didDelete(_ book: Book) {
        print("error in FailAddNewBookPresenter")
    }
    
    func didRecieve(_ books: [Book]) {
        print("error didRecieve in FailAddNewBookPresenter")
    }
    
    func didCreate(_ book: Book) {
        // MARK : проверить, что если получилось восстановить доступ к изображениям, то вьюха будет закрываться
        
        self.view?.dismissView()
    }
    
    func didFail(with error: Error) {
        print("error didFail in FailAddNewBookPresenter")
    }
    
    
    weak var view : FailAddNewBookViewControllerProtocol?
    
    var book: Book
    
    init(book: Book) {
        self.book = book
    }
    
    func didTapTryAgainButton() {
        view?.loadingAlert()
      
        BookManager.shared.output = self
        BookManager.shared.create(book: self.book)
    }

    func didTapQuitButton() {
        view?.dismissView()
    }
    
}
