//
//  AddBookPresenter.swift
//  Pickabook
//
//  Created by Timur on 05.11.2021.
//

import Foundation

class AddBookPresenter: PresenterInputProtocol{
    
    unowned let output: PresenterOutputProtocol
    
    required init(output: PresenterOutputProtocol) {
        self.output = output
    }
    
    func didTapButton() {
        let nameBook = "hochuSpat"
        self.output.setNameBook(book: nameBook)
    }
    
}
