//
//  MyProfilePresenter.swift
//  Pickabook
//
//  Created by Даниил Найко on 08.11.2021.
//

import Foundation

protocol BookViewPresenterProtocol: AnyObject {
    func heartButtonAction()
}

final class BookViewPresenter: BookViewPresenterProtocol {
    let genres = Util.shared.genres
    func heartButtonAction(){
        
    }
}
