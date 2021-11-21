//
//  FailAddNewBook.swift
//  Pickabook
//
//  Created by Timur on 19.11.2021.
//

import Foundation

protocol FailAddNewBookPresenterProtocol : AnyObject {
    func didTapTryAgainButton()
    func didTapQuitButton()
}

class FailAddNewBookPresenter : FailAddNewBookPresenterProtocol {
    
    weak var view : FailAddNewBookViewControllerProtocol?
    
    func didTapTryAgainButton() {
        // with data base
    }

    func didTapQuitButton() {
        view?.dismissView()
    }
    
}
