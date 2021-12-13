//
//  RegistrationPresenter.swift
//  Pickabook
//
//  Created by Даниил Найко on 19.11.2021.
//

import Foundation
import FirebaseFirestore
//output
protocol RegistrationViewControllerProtocol: AnyObject {
    //
}
 
protocol RegistrationPresenterProtocol: AnyObject {
    func didTapAddButton()
}
 
 
final class RegistrationPresenter: RegistrationPresenterProtocol {
    
    private let database = Firestore.firestore()
    
    weak var view: RegistrationViewControllerProtocol?
 
    func didTapAddButton() {
        //
    }
 
}

