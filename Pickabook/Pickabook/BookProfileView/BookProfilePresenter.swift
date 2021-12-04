//
//  BookProfilePresenter.swift
//  Pickabook
//
//  Created by Ульяна Цимбалистая on 04.12.2021.
//

import Foundation

protocol BookViewPresenterProtocol: AnyObject {
    func heartButtonAction()
    func takeBookButtonAction()
}

final class BookViewPresenter: BookViewPresenterProtocol {
    let genres = Util.shared.genres
    func heartButtonAction(){
        // добавление книги в избранное
    }
    
    func takeBookButtonAction(){
        // бронирование книги
    }
}
