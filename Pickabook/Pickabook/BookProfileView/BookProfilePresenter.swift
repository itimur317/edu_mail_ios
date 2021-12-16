//
//  BookProfilePresenter.swift
//  Pickabook
//
//  Created by Ульяна Цимбалистая on 04.12.2021.
//

import Foundation

protocol BookViewPresenterProtocol: AnyObject {
    func takeBookButtonAction(book: Book)
    func setViewDelegate(delegate: BookProfileViewController)
}

final class BookViewPresenter: BookViewPresenterProtocol {
    let genres = Util.shared.genres
    weak var delegate : BookProfileViewController?
    
    public func setViewDelegate(delegate: BookProfileViewController) {
        self.delegate = delegate
    }
    
    func takeBookButtonAction(book: Book){
        let owner = UserManager.shared.findUser(userId: book.ownerId!)
        print(owner)
        print("otkrivaet presenter")
        delegate?.presentNextVC(profile: owner)
    }
}
