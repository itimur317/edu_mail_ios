//
//  AddDoneViewController.swift
//  Pickabook
//
//  Created by Timur on 15.11.2021.
//

import Foundation
import UIKit 

class AddDoneViewController : UIViewController {
    
    let okButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        okButton.setTitle("Добавить", for: .normal)
        okButton.titleLabel?.textAlignment = .center
        okButton.setTitleColor(.white, for: .highlighted)
        okButton.backgroundColor = UIColor(red: 0.99, green: 0.53, blue: 0.16, alpha: 1.00)
        okButton.layer.cornerRadius = 10
    //    okButton.addTarget(self, action: #selector(didTapOkButton(_:)), for: .touchUpInside)
        view.addSubview(okButton)
    }
    
    
    
    
}
