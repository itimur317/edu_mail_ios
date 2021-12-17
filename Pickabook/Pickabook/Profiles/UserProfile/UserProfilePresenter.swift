//
//  UserProfilePresenter.swift
//  Pickabook
//
//  Created by Даниил Найко on 17.11.2021.
//

import Foundation
import FirebaseFirestore
//import FirebaseAuth //need be deleted
//output
protocol UserProfileViewControllerProtocol: AnyObject {
    func reloadTable()
    func reloadUserProfile(userProfile: Profile)
    
    func presentAlert(title: String, message: String)
    func changeProfileDataView()
    func openBook(book: Book)
}

protocol UserProfilePresenterProtocol: AnyObject {
    var currentBooks: [Book] { get set }
    var userProfile: Profile { get set }
    //var userId: String { get set }
    
    func observeBooks(userId: String)
    func observeUserProfile(userId: String)
    
    func didTapTelegramLinkButton()
    func didTapInstagramLinkButton()
    func didTapOpenBook(book: Book)
    
    func setViewDelegate(delegate: UserProfileViewControllerProtocol)
}


final class UserProfilePresenter: UserProfilePresenterProtocol {
    
    public func setViewDelegate(delegate: UserProfileViewControllerProtocol) {
        self.view = delegate
    }
    
    weak var view: UserProfileViewControllerProtocol?
    private let database = Firestore.firestore()
    
    var currentBooks: [Book] = []
    
    func observeBooks(userId: String) {
        DispatchQueue.global().async {
            BookManager.shared.output = self
            //guard let userId = Auth.auth().currentUser?.uid else { }
            BookManager.shared.observeOwnerIdBooks(id: userId)
        }
    }
    
    var userProfile: Profile = Profile.init(id: "", name: "", photoName: "", photo: nil, phoneNumber: nil, email: "", telegramLink: "", instagramLink: "")
    
    func observeUserProfile(userId: String) {
        UserManager.shared.output = self
        //guard let userId = Auth.auth().currentUser?.uid else { return }
        UserManager.shared.observeUser(userId: userId)
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


extension UserProfilePresenter : BookManagerOutput {
    func didRecieve(_ books: [Book]) {
        currentBooks = books.sorted(by: { $0.bookName < $1.bookName })
        self.view?.reloadTable()
    }
    
    func didCreate(_ book: Book) {
        print("error didCreate in MyProfilePresenter")
    }
    
    func didFail(with error: Error) {
        print("error didFail in MyProfilePresenter")
    }
    
    func didDelete(_ book: Book) {
        print("error didDelete in MyProfilePresenter")
    }
    
    
}

extension UserProfilePresenter : UserManagerOutput {
    
    func didRecieve(_ user: Profile) {
        print ("didRecieve IN WORK")
        print (user)
        self.view?.reloadUserProfile(userProfile: user)
    }
    
    func didCreate(_ user: Profile) { }
    
}

