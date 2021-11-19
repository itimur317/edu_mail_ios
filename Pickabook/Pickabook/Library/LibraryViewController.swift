//
//  LibraryViewController.swift
//  Pickabook
//
//  Created by Timur on 19.11.2021.
//

import Foundation
import UIKit
import PinLayout

protocol LibraryViewControllerProtocol : AnyObject {
    func showQuitAlert()
}

class LibraryViewController : UIViewController {
    
    var output: LibraryPresenterProtocol
    
    init(output: LibraryPresenterProtocol){
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let addNewBookButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addNewBookButton.setTitle("ADD BOOK", for: .normal)
        addNewBookButton.addTarget(self, action: #selector(didTapAddNewBookButton(_:)), for: .touchUpInside)
        addNewBookButton.backgroundColor = .red
        view.addSubview(addNewBookButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addNewBookButton.pin
            .left(view.frame.width / 2 - 50)
            .top(200)
            .height(200)
            .width(100)
    }
    
    @objc
    func didTapAddNewBookButton(_ sender: UIButton) {
        let addNewBookPresenter = AddNewBookPresenter()
        let addNewBookViewController = AddNewBookViewController(output: addNewBookPresenter)
        addNewBookPresenter.view = addNewBookViewController
     //   addNewBookViewController.modalPresentationStyle = .fullScreen
        present(addNewBookViewController, animated: true, completion: nil)
    }
}

extension LibraryViewController: LibraryViewControllerProtocol {
    func showQuitAlert() {
        let alert = UIAlertController(title: "Выйти?", message: "Данные не сохранятся", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .destructive, handler: {
            action in
            
            self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        
    }
}
