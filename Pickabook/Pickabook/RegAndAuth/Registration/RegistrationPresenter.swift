//
//  RegistrationPresenter.swift
//  Pickabook
//
//  Created by Даниил Найко on 19.11.2021.
//

import Foundation
//output
protocol RegistrationViewControllerProtocol: AnyObject {
    //
}
 
protocol RegistrationPresenterProtocol: AnyObject {
    func didTapAddButton()
}
 
 
final class RegistrationPresenter: RegistrationPresenterProtocol {
    
    weak var view: RegistrationViewControllerProtocol?
 
    func didTapAddButton() {
        //
    }
 
}

