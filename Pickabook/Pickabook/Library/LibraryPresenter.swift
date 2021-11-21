//
//  LibraryPresenter.swift
//  Pickabook
//
//  Created by Timur on 19.11.2021.
//

import Foundation

protocol LibraryPresenterProtocol : AnyObject {
    
}

class LibraryPresenter : LibraryPresenterProtocol {
    
    weak var view : LibraryViewControllerProtocol?
    
    func dismissView(){
        view?.dismissView()
    }

}
