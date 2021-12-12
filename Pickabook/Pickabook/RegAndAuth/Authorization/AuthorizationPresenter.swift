//
//  AuthorizationPresenter.swift
//  Pickabook
//
//  Created by Даниил Найко on 18.11.2021.
//

import Foundation
//output
protocol AuthorizationViewControllerProtocol: AnyObject {
    func regTapped()
}
 
protocol AuthorizationPresenterProtocol: AnyObject {
    func didTapRegButton()
}
 
 
final class AuthorizationPresenter: AuthorizationPresenterProtocol {
    
    weak var view: AuthorizationViewControllerProtocol?
    
    func didTapRegButton() {
        self.view?.regTapped()
    }
    
}

