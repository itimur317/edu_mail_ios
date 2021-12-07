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

final class FailAddNewBookPresenter : FailAddNewBookPresenterProtocol {
    
    weak var view : FailAddNewBookViewControllerProtocol?
    
    var book: Book
    
    init(book: Book) {
        self.book = book
    }
    
    func didTapTryAgainButton() {
      // тут нужен презентер аутпут делать
        BookManager.shared.create(book: self.book)
    }

    func didTapQuitButton() {
        view?.dismissView()
    }
    
}
