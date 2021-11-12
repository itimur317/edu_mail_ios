//
//  AddBookPresenter.swift
//  Pickabook
//
//  Created by Timur on 05.11.2021.
//
 
import Foundation

//output
protocol AddNewBookViewControllerProtocol: AnyObject {
    var newBook: Book? { get set }
    func saveTextViewContents()
}
 
protocol AddNewBookPresenterProtocol: AnyObject {
    var newBook: Book? { get set }
    func didTapAddButton()
}
 
 
final class AddNewBookPresenter: AddNewBookPresenterProtocol {
    
    weak var view: AddNewBookViewControllerProtocol?
    var newBook: Book?
 
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
 
 
 
 
