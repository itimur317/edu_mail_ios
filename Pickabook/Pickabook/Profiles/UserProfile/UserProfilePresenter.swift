//
//  UserProfilePresenter.swift
//  Pickabook
//
//  Created by Даниил Найко on 17.11.2021.
//

import Foundation
import FirebaseAuth

//output
protocol UserProfileViewControllerProtocol: AnyObject {
    func presentProfile(profiles: [Profile])
    func presentAlert(title: String, message: String)
    func changeProfileDataView()
    func openBook(book: Book)
    func reloadProfile(profile: Profile)
}
 
protocol UserProfilePresenterProtocol: AnyObject {
    func didTapTelegramLinkButton()
    func didTapInstagramLinkButton()
    func didTapOpenBook(book: Book)
    func observeProfile()
}
 
extension UserProfilePresenter : UserManagerOutput {
    func didFail(with error: Error) {
        print("error")
    }
    
    func didRecieve(_ user: Profile) {
        print ("didRecieve IN WORK")
        print (user)
        self.view?.reloadProfile(profile: user)
    }
    
    func didCreate(_ user: Profile) { }
    
}

final class UserProfilePresenter: UserProfilePresenterProtocol {
    
    weak var view: UserProfileViewControllerProtocol?
    
    func observeProfile() {
        UserManager.shared.output = self
        guard let MyId = Auth.auth().currentUser?.uid else { return }
        UserManager.shared.observeUser(userId: MyId)
    }
    
    func didTapOpenBook(book: Book) {
        self.view?.openBook(book:  book)
    }
    
    func didTapTelegramLinkButton() {
        self.view?.changeProfileDataView()
    }
    
    func didTapInstagramLinkButton() {
        self.view?.changeProfileDataView()
    }
    
}

