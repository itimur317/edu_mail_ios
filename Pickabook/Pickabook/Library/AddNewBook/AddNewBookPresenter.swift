//
//  AddBookPresenter.swift
//  Pickabook
//
//  Created by Timur on 05.11.2021.
//
 
import Foundation
import UIKit
// added only for UIColor
// убрать когда решим цвет фона какой будет

 
protocol AddNewBookPresenterProtocol: AnyObject {
    var newBook: Book { get set }
    func didTapAddButton(bookImages: [Data?],
                         bookName: String,
                         bookNameColor: UIColor,
                         authorName: String,
                         authorNameColor : UIColor,
                         bookDescription: String,
                         bookDescriptionColor : UIColor,
                         bookLanguage: String,
                         bookLanguageColor: UIColor)
    func didTapConditionButton(_ addedCondition: Int)
    func didTapAddPhotoButton()
}
 
 
final class AddNewBookPresenter {
    var newBook: Book
    var genres = Util.shared.genres
    
    init() {
        newBook = Book(bookImages: [],
                       bookName: "",
                       bookAuthor: "",
                       bookGenres: genres[0],
                       bookCondition: 0,
                       bookDescription: nil,
                       bookLanguage: "Русский")
    }
    weak var view : AddNewBookViewControllerProtocol?
    
}

extension AddNewBookPresenter: BookManagerOutput {
    func didDelete(_ book: Book) {
        print("error didDelete in AddNewBookPresenter")
    }
    
    func didRecieve(_ books: [Book]) {
        print("error didRecive in AddNewBookPresenter")
    }
    
    func didCreate(_ book: Book) {
        self.view?.dismissLoadingAlert()
        self.view?.successAddDoneView()
    }
    
    func didFail(with error: Error) {
        self.view?.dismissLoadingAlert()
        self.view?.failAddDoneView()
    }
    
    
}
    
extension AddNewBookPresenter: AddNewBookPresenterProtocol  {
    
    func didTapAddButton(bookImages:[Data?],
                         bookName: String,
                         bookNameColor: UIColor,
                         authorName: String,
                         authorNameColor : UIColor,
                         bookDescription: String,
                         bookDescriptionColor : UIColor,
                         bookLanguage: String,
                         bookLanguageColor: UIColor) {
        
        view?.presentLoadingAlert()
        
        if (bookImages[1] == nil || bookName == "" ||  authorName == ""
            ||  bookLanguage == "" || bookNameColor == .gray
            || authorNameColor == .gray  || self.newBook.bookCondition == 0
            || self.newBook.bookGenres.type == genres[0].type) {
            
            self.view?.requiredFieldAlert()
            
        } else {
            
            // when added just centerImage
            if bookImages[2] == nil {
                self.newBook.bookImages = [bookImages[1]!]
            }
            
            // when added centerImage and rightImage
            else if bookImages[0] == nil {
                self.newBook.bookImages = [bookImages[2]!, bookImages[1]!]
            }
            
            // all added
            else {
                self.newBook.bookImages = [bookImages[2]!, bookImages[1]! , bookImages[0]!]
            }
            
           
           
            
            self.newBook.bookName = bookName
            self.newBook.bookAuthor = authorName
            if bookDescription == "" || bookDescriptionColor == .gray{
                self.newBook.bookDescription = nil
            } else {
                self.newBook.bookDescription = bookDescription
            }
            self.newBook.bookLanguage = bookLanguage
            
            
            print(self.newBook.identifier)
            print(self.newBook.bookImages)
            print(self.newBook.bookName)
            print(self.newBook.bookAuthor)
            print(self.newBook.bookCondition)
            print(self.newBook.bookGenres)
            print(self.newBook.bookDescription)
            print(self.newBook.bookLanguage)
            
            BookManager.shared.output = self
            BookManager.shared.create(book: newBook)

        }
    }
 
    func didTapConditionButton(_ addedCondition: Int) {
        newBook.bookCondition = addedCondition
        self.view?.changeCondition(addedCondition)
    }

    func didTapAddPhotoButton() {
        //
    }
    
}

 

 
 
 
