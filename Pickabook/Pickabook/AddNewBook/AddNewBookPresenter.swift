//
//  AddBookPresenter.swift
//  Pickabook
//
//  Created by Timur on 05.11.2021.
//
 
import Foundation

 
protocol AddNewBookPresenterProtocol: AnyObject {
    var newBook: Book? { get set }
    func didTapAddButton()
    func showMenuAlert()
}
 
 
final class AddNewBookPresenter: AddNewBookPresenterProtocol {
    
    weak var view: AddNewBookViewControllerProtocol?
    var newBook: Book?
    
    func showMenuAlert() {
        view?.showMenuAlert()
    }

    
    
    
    func didTapAddButton() {
        
    }
 
 
}
 
 
 
 
 
 
 
 
 
 

 
 
 
 
 
/*
class AddBookPresenter: PresenterInputProtocol{
 
    let output: PresenterOutputProtocol
    let book: Book
 
    required init(output: PresenterOutputProtocol, book: Book) {
        self.output = output
        self.book = book
    }
 
    func didTapButton() {
        let nameBook = book.nameBook
        self.output.setNameBook(book: nameBook)
    }
 
}
*/
 
 
 
 
