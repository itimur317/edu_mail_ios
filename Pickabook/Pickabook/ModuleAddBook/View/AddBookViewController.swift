//
//  AddBookViewController.swift
//  Pickabook
//
//  Created by Timur on 05.11.2021.
//

import Foundation
import UIKit

// хуйня позволяющая менять внутри viewcontr имя кнопки и тп
// 
protocol PresenterOutputProtocol: AnyObject {
    func setNameBook(book: String)
}

// будет что то внутри презентера вертеться
// и потом вернется обратно во viewcontr
// она должна указать презентеру на то, что надо бы уметь обрабатывать нажатую
// кнопку в развернутом виде
protocol PresenterInputProtocol: AnyObject {
    init(output: PresenterOutputProtocol)
    func didTapButton()
}


class AddBookViewController: PresenterOutputProtocol {
    var presenter: PresenterInputProtocol!
    
    @IBOutlet weak var addNameButton: UILabel!
    
    @IBAction func didTapButton(_ sender: Any){
        self.presenter.didTapButton()
    }
    
    
    func setNameBook(book: String) {
        self.addNameButton.text = book
    }
    
   
    
}



// showGreeting у андрея он в презентере обработал простенько быстренько полное имя и затем сразу же его засетил во вью контроллер обратно

