//
//  BookProfilePresenter.swift
//  Pickabook
//
//  Created by Ульяна Цимбалистая on 04.12.2021.
//

import Foundation

protocol BookViewPresenterProtocol: AnyObject {
    var bookOwner: Profile { get set }
    
    func takeBookButtonAction(book: Book)
    func setViewDelegate(delegate: BookProfileViewController)
    func observeBookOwner(ownerId: String)
}

final class BookViewPresenter: BookViewPresenterProtocol {
    var bookOwner: Profile = Profile.init(id: "", name: "", photoName: "", photo: nil, phoneNumber: nil, email: "", telegramLink: "", instagramLink: "")
    let genres = Util.shared.genres
    weak var delegate : BookProfileViewController?
    
    public func setViewDelegate(delegate: BookProfileViewController) {
        self.delegate = delegate
    }
    
    func takeBookButtonAction(book: Book){
        delegate?.presentNextVC()
    }
    
    func observeBookOwner(ownerId: String) {
        UserManager.shared.output = self
        //guard let userId = Auth.auth().currentUser?.uid else { return }
        UserManager.shared.observeUser(userId: ownerId)
    }
}

extension BookViewPresenter : UserManagerOutput {
    func didFail(with error: Error) {
        print("fail")
    }
    
    func didRecieve(_ user: Profile) {
        self.delegate?.loadBookOwner(ownerProfile: user)
    }
    
    func didCreate(_ user: Profile) { }
    
}
