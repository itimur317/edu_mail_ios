//
//  AddDoneViewController.swift
//  Pickabook
//
//  Created by Timur on 15.11.2021.
//

import Foundation
import UIKit
import PinLayout

protocol SuccessAddNewBookViewControllerProtocol : AnyObject {
    func dismissView()
}

final class SuccessAddNewBookViewController : UIViewController {
    
    var presenter: SuccessAddNewBookPresenterProtocol
    
    init(presenter: SuccessAddNewBookPresenterProtocol){
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let addedNewBookLabel = UILabel()
    let daultyImage = UIImage(named: "successAddNewBookImage")
    let daultyImageView = UIImageView()
    let okButton = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addedNewBookLabel.text = "Успех!"
        addedNewBookLabel.textColor = UIColor(red: 0.99, green: 0.53, blue: 0.16, alpha: 1.00)
        addedNewBookLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        addedNewBookLabel.backgroundColor = .white
        addedNewBookLabel.textAlignment = .center
        view.addSubview(addedNewBookLabel)
        
        daultyImageView.image = daultyImage
        view.addSubview(daultyImageView)
        
        okButton.setTitle("Отлично", for: .normal)
        okButton.titleLabel?.textAlignment = .center
        okButton.setTitleColor(.white, for: .highlighted)
        okButton.backgroundColor = UIColor(named: "buttonColor")
        okButton.layer.cornerRadius = 10
        okButton.addTarget(self,
                           action: #selector(didTapOkButton(_:)),
                           for: .touchUpInside)
        view.addSubview(okButton)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addedNewBookLabel.pin
            .top(view.frame.height / 9)
            .horizontally(12)
            .height(60)
        
        daultyImageView.pin
            .below(of: addedNewBookLabel).marginTop(20)
            .horizontally(view.frame.width / 16 + 12)
            .width(view.frame.width * 7 / 8 - 12 * 2)
            .height((view.frame.width * 7 / 8 - 12 * 2) * 1.1)
        
        okButton.pin
            .below(of: daultyImageView).marginTop(40)
            .left(view.frame.width / 2 - 65)
            .width(130)
            .height(40)
        
    }
    
    @objc
    private func didTapOkButton(_ sender: UIButton) {
        presenter.didTapOkButton()
    }
    
}

extension SuccessAddNewBookViewController: SuccessAddNewBookViewControllerProtocol {
    
    func dismissView() {
        dismiss(animated: true, completion: nil)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
