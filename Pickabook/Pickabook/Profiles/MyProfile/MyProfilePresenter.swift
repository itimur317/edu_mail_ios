//
//  MyProfilePresenter.swift
//  Pickabook
//
//  Created by Даниил Найко on 08.11.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

//output
protocol MyProfileViewControllerProtocol: AnyObject {
    func reloadTable()
    func reloadMyProfile(myProfile: Profile)
    //var output: MyProfilePresenter
    func presentProfile(profiles: [Profile])
    func presentAlert(title: String, message: String)
    func changeProfileDataView()
    func openBook(book: Book)
    //func loadProfileData(profileData: Profile)
}
 
protocol MyProfilePresenterProtocol: AnyObject {
    
    var currentBooks: [Book] { get set }
    var myProfile: Profile { get set }
    
    func observeBooks()
    func observeMyProfile()
    func didTapChangeProfileDataButton()
    func didTapOpenBook(book: Book)
    func setViewDelegate(delegate: MyProfileViewControllerProtocol)
    //func didLoadProfileData()
    //func didFail(with error: Error)
}
 
 
final class MyProfilePresenter: MyProfilePresenterProtocol {
    
    var currentBooks: [Book] = []
    
    func observeBooks() {
        DispatchQueue.global().async {
            BookManager.shared.output = self
            guard let MyId = Auth.auth().currentUser?.uid else {
                print("didn't register")
                return
            }
            BookManager.shared.observeOwnerIdBooks(id: MyId)
        }
    }
    
    var myProfile: Profile = Profile.init(id: "", name: "", photoName: "", photo: nil, phoneNumber: nil, email: "", telegramLink: "", instagramLink: "")
    
    func observeMyProfile() {
        UserManager.shared.output = self
        guard let MyId = Auth.auth().currentUser?.uid else { return }
        UserManager.shared.observeUser(userId: MyId)
    }
    
    private let database = Firestore.firestore()
    //private let profileDataConverter = ProfileDataConverter()
    
    weak var view: MyProfileViewControllerProtocol?
    
    //public func getProfiles() {}
    
    func didTapOpenBook(book: Book) {
        self.view?.openBook(book:  book)
    }
    
    func didTapChangeProfileDataButton() {
        self.view?.changeProfileDataView()
    }
    
    public func setViewDelegate(delegate: MyProfileViewControllerProtocol) {
        self.view = delegate
    }
    
}


extension MyProfilePresenter : BookManagerOutput {
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

extension MyProfilePresenter : UserManagerOutput {
    
    func didRecieve(_ user: Profile) {
        print ("didRecieve IN WORK")
        print (user)
        self.view?.reloadMyProfile(myProfile: user)
    }
    
    func didCreate(_ user: Profile) { }
    
}
