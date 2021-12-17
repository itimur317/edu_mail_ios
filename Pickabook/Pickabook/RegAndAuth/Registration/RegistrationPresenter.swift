//
//  RegistrationPresenter.swift
//  Pickabook
//
//  Created by Даниил Найко on 19.11.2021.
//

import Foundation
import FirebaseAuth
import UIKit
//import FirebaseFirestore
//output
protocol RegistrationViewControllerProtocol: AnyObject {
    func openSavedPhotosAlbum()
}

protocol RegistrationPresenterProtocol: AnyObject {
    //    func didTapAddButton()
    func setViewDelegate(delegate: RegistrationViewControllerProtocol)
    func didTapAddPhotoButton()
    
    var newUser: Profile { get set }
    func didTapRegButton(//id: String,
        name: String,
        photoName: String?,
        photo: UIImage?,//Data?,
        phoneNumber: String?,
        email: String?,
        telegramLink: String?,
        instagramLink: String?)
}


final class RegistrationPresenter: RegistrationPresenterProtocol, UserManagerOutput {
    
    weak var view: RegistrationViewControllerProtocol?
    
    func didRecieve(_ user: Profile) { }
    func didCreate(_ user: Profile) { }
    func didFail(with error: Error) { }
    
    public func setViewDelegate(delegate: RegistrationViewControllerProtocol) {
        self.view = delegate
    }
    
    func didTapAddPhotoButton() {
        self.view?.openSavedPhotosAlbum()
    }
    
    var newUser: Profile
    init() {
        newUser = Profile(  id: "",
                            name: "",
                            photoName: "",
                            photo: UIImage(named: "addPhotoImage"),
                            phoneNumber: "",
                            email: "",
                            telegramLink: nil,
                            instagramLink: nil  )
    }
    
    func didTapRegButton( //id: String,
        name: String,
        photoName: String?,
        photo: UIImage?,
        phoneNumber: String?,
        email: String?,
        telegramLink: String?,
        instagramLink: String? ) {
            
            guard let newUserId = Auth.auth().currentUser?.uid else { return }
            self.newUser.id = newUserId
            self.newUser.photo = photo!
            self.newUser.name = name
            self.newUser.phoneNumber = phoneNumber
            self.newUser.email = email!
            self.newUser.telegramLink = telegramLink
            self.newUser.instagramLink = instagramLink
            
            //        print(self.newUser.identifier)
            //        print(self.newUser.userImages)
            //        print(self.newUser.userName)
            //        print(self.newUser.userAuthor)
            //        print(self.newUser.userCondition)
            //        print(self.newUser.userGenres)
            //        print(self.newUser.userDescription)
            //        print(self.newUser.userLanguage)
            
            UserManager.shared.output = self
            UserManager.shared.create(user: newUser)
        }
}
