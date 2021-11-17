//
//  MyProfilePresenter.swift
//  Pickabook
//
//  Created by Даниил Найко on 08.11.2021.
//

import Foundation
//output
protocol MyProfileViewControllerProtocol: AnyObject {
    func presentProfile(profiles: [Profile])
    func presentAlert(title: String, message: String)
    func changeProfileDataView()
    //var bookList: [Book]? { get }
    /*  func setBookAuthor(author: String)
    func setBookGenres(genres: [Int])
    func setBookCondition(condition: Int)
    func setBookDescription(description: String?)
    func setBookLanguage(language: String)*/
}
 
protocol MyProfilePresenterProtocol: AnyObject {
    func didTapChangeProfileDataButton()
}
 
 
final class MyProfilePresenter: MyProfilePresenterProtocol {
    
    weak var view: MyProfileViewControllerProtocol?
    
//    public func getProfiles() {
//    }
    
    func didTapChangeProfileDataButton() {
        self.view?.changeProfileDataView()
    }
 
}
