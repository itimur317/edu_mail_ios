//
//  AuthorizationPresenter.swift
//  Pickabook
//
//  Created by Даниил Найко on 18.11.2021.
//

import Foundation
//output
protocol AuthorizationViewControllerProtocol: AnyObject {
    //func presentProfile(profiles: [Profile])
    //func presentAlert(title: String, message: String)
    //var bookList: [Book]? { get }
    /*  func setBookAuthor(author: String)
    func setBookGenres(genres: [Int])
    func setBookCondition(condition: Int)
    func setBookDescription(description: String?)
    func setBookLanguage(language: String)*/
}
 
protocol AuthorizationPresenterProtocol: AnyObject {
    func didTapAddButton()
}
 
 
final class AuthorizationPresenter: AuthorizationPresenterProtocol {
    
    weak var view: AuthorizationViewControllerProtocol?
    
//    //var bookList: [Book]?
//    public func getProfiles() {
//        //
//    }
 
    func didTapAddButton() {
        //
    }
 
}

