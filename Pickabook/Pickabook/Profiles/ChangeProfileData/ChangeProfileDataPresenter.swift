//
//  ChangeProfileDataPresenter.swift
//  Pickabook
//
//  Created by Даниил Найко on 15.11.2021.
//

import Foundation
//output
protocol ChangeProfileDataViewControllerProtocol: AnyObject {
    func openSavedPhotosAlbum()
    //func presentProfile(profiles: [Profile])
    //func presentAlert(title: String, message: String)
    //var bookList: [Book]? { get }
    /*  func setBookAuthor(author: String)
    func setBookGenres(genres: [Int])
    func setBookCondition(condition: Int)
    func setBookDescription(description: String?)
    func setBookLanguage(language: String)*/
}
 
protocol ChangeProfileDataPresenterProtocol: AnyObject {
    func didTapAddPhotoButton()
    func didTapAddButton()
    func setViewDelegate(delegate: ChangeProfileDataViewControllerProtocol)
}
 
 
final class ChangeProfileDataPresenter: ChangeProfileDataPresenterProtocol {
    
    weak var view: ChangeProfileDataViewControllerProtocol?
    
//    //var bookList: [Book]?
//    public func getProfiles() {
//        //
//    }
    
    public func setViewDelegate(delegate: ChangeProfileDataViewControllerProtocol) {
        self.view = delegate
    }
    
    func didTapAddPhotoButton() {
        self.view?.openSavedPhotosAlbum()
    }
 
    func didTapAddButton() {
        //
    }
 
}
