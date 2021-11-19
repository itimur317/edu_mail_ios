//
//  AddedNewBookPresenter.swift
//  Pickabook
//
//  Created by Timur on 16.11.2021.
//

import Foundation

protocol SuccessAddNewBookPresenterProtocol : AnyObject {
    func didTapOkButton()
}

class SuccessAddNewBookPresenter : SuccessAddNewBookPresenterProtocol {
    
    weak var view : SuccessAddNewBookViewControllerProtocol?
    
    func didTapOkButton() {
        view?.dismissView()
    }


}
