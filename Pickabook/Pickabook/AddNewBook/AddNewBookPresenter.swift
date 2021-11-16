//
//  AddBookPresenter.swift
//  Pickabook
//
//  Created by Timur on 05.11.2021.
//
 
import Foundation

 
protocol AddNewBookPresenterProtocol: AnyObject {
    var newBook: Book? { get }
    func didTapAddButton()
    func didTapConditionButton(_ addedCondition: Int)
    func showMenuAlert()
}
 
 
final class AddNewBookPresenter{
    var newBook: Book?
    weak var view: AddNewBookViewControllerProtocol?
    // newBook nil and condition ne zapolnyaetsya
    
    
}
    
extension AddNewBookPresenter: AddNewBookPresenterProtocol {
    
    func showMenuAlert() {
        
    }
    
    
    func didTapAddButton() {
        self.view?.showMenuAlert()
    }
 
    func didTapConditionButton(_ addedCondition: Int) {
        newBook?.bookCondition = addedCondition
        self.view?.changeCondition(addedCondition)
    }

}

 

 
 
 
