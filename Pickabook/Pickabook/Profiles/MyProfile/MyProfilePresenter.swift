//
//  MyProfilePresenter.swift
//  Pickabook
//
//  Created by Даниил Найко on 08.11.2021.
//

import Foundation
import FirebaseFirestore

//output
protocol MyProfileViewControllerProtocol: AnyObject {
    //var output: MyProfilePresenter
    func presentProfile(profiles: [Profile])
    func presentAlert(title: String, message: String)
    func changeProfileDataView()
    func openBook(book: Book)
//    func loadProfileData(profileData: Profile)
}
 
protocol MyProfilePresenterProtocol: AnyObject {
    func didTapChangeProfileDataButton()
    func didTapOpenBook(book: Book)
//    func didLoadProfileData()
    
    //func didFail(with error: Error)
}
 
 
final class MyProfilePresenter: MyProfilePresenterProtocol {
    
    private let database = Firestore.firestore()
    private let profileDataConverter = ProfileDataConverter()
    
    weak var view: MyProfileViewControllerProtocol?
    
//    public func getProfiles() {}
    
    func didTapOpenBook(book: Book) {
        self.view?.openBook(book:  book)
    }
    
    func didTapChangeProfileDataButton() {
        self.view?.changeProfileDataView()
    }
    
//    func didLoadProfileData() {
//        database.collection("Users").addSnapshotListener { querySnapshot, error in
//            if let error = error { return }
//            guard let documents = querySnapshot?.documents else { return }
//            let profileData = documents.compactMap { self.profileDataConverter.profileData(from: $0) }
//            self?.view?.loadProfileData(profileData: profileData)
//        }
//    }
}






private final class ProfileDataConverter {
    
    enum Key: String {
        case email
        case id
        case instagramLink
        case name
        case phoneNumber
        case photoName
        case telegramLink
    }
    
    func profileData (from document: DocumentSnapshot) -> Profile? {
        guard let dict = document.data(),
              let id = dict[Key.id.rawValue] as? String,
              let name = dict[Key.name.rawValue] as? String,
              let phoneNumber = dict[Key.phoneNumber.rawValue] as? Int,
              let email = dict[Key.email.rawValue] as? String,
              let telegramLink = dict[Key.telegramLink.rawValue] as? URL,
              let instagramLink = dict[Key.instagramLink.rawValue] as? URL else { return nil }
        let photoName = dict[Key.photoName.rawValue] as? String
        
        let profileData = Profile(id: id, name: name, photoName: photoName, phoneNumber: phoneNumber, email: email, telegramLink: telegramLink, instagramLink: instagramLink)
        return profileData
    }
    
}
