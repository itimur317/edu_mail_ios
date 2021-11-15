//
//  AddBookPresenter.swift
//  Pickabook
//
//  Created by Timur on 05.11.2021.
//
 
import Foundation
import UIKit

 
protocol AddNewBookPresenterProtocol: AnyObject {
    var newBook: Book { get set }
    func didTapAddButton(bookName: String, bookNameColor: UIColor, authorName: String, authorNameColor : UIColor, bookDescription: String,bookDescriptionColor : UIColor, bookLanguage: String, bookLanguageColor: UIColor)
    func didTapConditionButton(_ addedCondition: Int)
  //  func didChooseGenre()
    func showMenuAlert()
}
 
 
final class AddNewBookPresenter{
    var newBook: Book
    init(){
        newBook = Book(bookImages: nil, bookName: "", bookAuthor: "", bookGenre: "Не выбран" , bookCondition: 0, bookDescription: nil, bookLanguage: "Русский")
    }
    weak var view : AddNewBookViewControllerProtocol?
    
    var router : AddNewBookRouterProtocol?
    
    
}
    
extension AddNewBookPresenter: AddNewBookPresenterProtocol {
    
    func didTapAddButton(bookName: String, bookNameColor: UIColor, authorName: String, authorNameColor : UIColor, bookDescription: String,bookDescriptionColor : UIColor, bookLanguage: String, bookLanguageColor: UIColor) {
        
        if (bookName == "" ||  authorName == "" ||  bookLanguage == "" || bookNameColor == .gray || authorNameColor == .gray  || self.newBook.bookCondition == 0 || self.newBook.bookGenre == "Не выбран") {
            
            self.view?.requiredFieldAlert()
            
        } else {
            
            self.newBook.bookName = bookName
            self.newBook.bookAuthor = authorName
            if bookDescription == "" || bookDescriptionColor == .gray{
                self.newBook.bookDescription = nil
            } else {
                self.newBook.bookDescription = bookDescription
            }
            self.newBook.bookLanguage = bookLanguage
            self.view?.openAddDoneView()
         //   self.router.openAddDoneView()
        }
        

        print(self.newBook.bookName)
        print(self.newBook.bookAuthor)
        print(self.newBook.bookCondition)
        print(self.newBook.bookGenre)
        print(self.newBook.bookDescription)
        print(self.newBook.bookLanguage)

    }
    
    
    func showMenuAlert() {
        
    }
    
    
//    func didTapAddButton() {
//        self.view?.showMenuAlert()
//    }
 
    func didTapConditionButton(_ addedCondition: Int) {
        newBook.bookCondition = addedCondition
        self.view?.changeCondition(addedCondition)
    }

}

 

 
 
 
