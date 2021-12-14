//
//  RegistrationPresenter.swift
//  Pickabook
//
//  Created by Даниил Найко on 19.11.2021.
//

import Foundation
//import FirebaseFirestore
//output
protocol RegistrationViewControllerProtocol: AnyObject {
    func openSavedPhotosAlbum()
}
 
protocol RegistrationPresenterProtocol: AnyObject {
//    func didTapAddButton()
    func setViewDelegate(delegate: RegistrationViewControllerProtocol)
    func didTapAddPhotoButton()
}
 
 
final class RegistrationPresenter: RegistrationPresenterProtocol {
    
    //private let database = Firestore.firestore()
    
    weak var view: RegistrationViewControllerProtocol?
    
    public func setViewDelegate(delegate: RegistrationViewControllerProtocol) {
        self.view = delegate
    }
    
    func didTapAddPhotoButton() {
        self.view?.openSavedPhotosAlbum()
    }
 
//    func didTapAddButton() {
//        //
//    }
 
}

//extension RegistrationPresenter : UserManagerOutput {
//    func didDelete(_ book: Book) {
//        self.view?.successDeleteAlert()
//    }
//
//    func didRecieve(_ books: [Book]) {
//        print("didRecieve in LibraryPresenter")
//        currentBooks = books
//        self.view?.reloadTable()
//    }
//
//    func didCreate(_ book: Book) {
//        print("error didCreate in LibraryPresenter")
//    }
//
//    func didFail(with error: Error) {
//        self.view?.errorAlert()
//    }
//}


