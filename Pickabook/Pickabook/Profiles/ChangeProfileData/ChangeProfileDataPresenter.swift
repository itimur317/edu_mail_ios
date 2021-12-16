//
//  ChangeProfileDataPresenter.swift
//  Pickabook
//
//  Created by Даниил Найко on 15.11.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
//output
protocol ChangeProfileDataViewControllerProtocol: AnyObject {
    func openSavedPhotosAlbum()
    func reloadMyProfile(myProfile: Profile)
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
    var myProfile: Profile { get set }
    func observeMyProfile()
    
    func didTapAddPhotoButton()
    func didTapAddButton()
    func setViewDelegate(delegate: ChangeProfileDataViewControllerProtocol)
}
 
 
final class ChangeProfileDataPresenter: ChangeProfileDataPresenterProtocol {
    
    weak var view: ChangeProfileDataViewControllerProtocol?
    private let database = Firestore.firestore()
    
    var myProfile: Profile = Profile.init(id: "", name: "", photoName: "", photo: nil, phoneNumber: "", email: "", telegramLink: "", instagramLink: "")
    
    func observeMyProfile() {
        UserManager.shared.output = self
        guard let MyId = Auth.auth().currentUser?.uid else { return }
        UserManager.shared.observeUser(userId: MyId)
    }
    
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

extension ChangeProfileDataPresenter : UserManagerOutput {
    
    func didFail(with error: Error) {
        //
    }
    
    func didRecieve(_ user: Profile) {
        print ("didRecieve IN WORK")
        print (user)
        self.view?.reloadMyProfile(myProfile: user)
    }
    
    func didCreate(_ user: Profile) { }
    
}
