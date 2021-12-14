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
    //func loadProfileData(profileData: Profile)
}
 
protocol MyProfilePresenterProtocol: AnyObject {
    func didTapChangeProfileDataButton()
    func didTapOpenBook(book: Book)
    func setViewDelegate(delegate: MyProfileViewControllerProtocol)
    //func didLoadProfileData()
    //func didFail(with error: Error)
}
 
 
final class MyProfilePresenter: MyProfilePresenterProtocol {
    
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
//    func didLoadProfileData() {
//        database.collection("Users").addSnapshotListener { querySnapshot, error in
//            if let error = error { return }
//            guard let documents = querySnapshot?.documents else { return }
//            let profileData = documents.compactMap { self.profileDataConverter.profileData(from: $0) }
//            self?.view?.loadProfileData(profileData: profileData)
//        }
//    }
    
}
