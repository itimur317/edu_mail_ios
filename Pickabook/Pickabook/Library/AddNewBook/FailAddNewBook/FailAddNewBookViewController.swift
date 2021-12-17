//
//  FailNewBookViewController.swift
//  Pickabook
//
//  Created by Timur on 19.11.2021.
//

import Foundation
import UIKit
import PinLayout

protocol FailAddNewBookViewControllerProtocol : AnyObject {
    func dismissView()
    func loadingAlert()
}

final class FailAddNewBookViewController : UIViewController {
    
    var presenter: FailAddNewBookPresenterProtocol
    
    init(presenter: FailAddNewBookPresenterProtocol){
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let addedNewBookLabel = UILabel()
    let daultyImage = UIImage(named: "failAddNewBookImage")
    let daultyImageView = UIImageView()
    let tryAgainButton = UIButton()
    let quitButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addedNewBookLabel.text = "Что-то пошло не так..."
        addedNewBookLabel.textColor = UIColor(red: 0.99, green: 0.53, blue: 0.16, alpha: 1.00)
        addedNewBookLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        addedNewBookLabel.backgroundColor = .white
        addedNewBookLabel.textAlignment = .center
        view.addSubview(addedNewBookLabel)
        
        daultyImageView.image = daultyImage
        view.addSubview(daultyImageView)
        
        tryAgainButton.setTitle("Попробовать снова", for: .normal)
        tryAgainButton.titleLabel?.textAlignment = .center
        tryAgainButton.setTitleColor(.white, for: .highlighted)
        tryAgainButton.backgroundColor = UIColor(named: "buttonColor")
        tryAgainButton.layer.cornerRadius = 10
        tryAgainButton.addTarget(self,
                                 action: #selector(didTapTryAgainButton(_:)),
                                 for: .touchUpInside)
        view.addSubview(tryAgainButton)
        
        quitButton.setTitle("Выйти", for: .normal)
        quitButton.titleLabel?.textAlignment = .center
        quitButton.setTitleColor(UIColor(red: 0.29, green: 0.16, blue: 0.15, alpha: 1.00), for: .normal)
        quitButton.backgroundColor = .white
        quitButton.addTarget(self,
                             action: #selector(didTapQuitButton(_:)),
                             for: .touchUpInside)
        view.addSubview(quitButton)
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
        
        tryAgainButton.pin
            .below(of: daultyImageView).marginTop(40)
            .left(view.frame.width / 2 - 100)
            .width(200)
            .height(40)
        
        quitButton.pin
            .below(of: tryAgainButton).marginTop(12)
            .left(view.frame.width / 2 - 50)
            .width(100)
            .height(30)
        
    }
    
    
    @objc
    private func didTapTryAgainButton(_ sender: UIButton) {
        presenter.didTapTryAgainButton()
    }
    
    
    @objc
    private func didTapQuitButton(_ sender: UIButton) {
        presenter.didTapQuitButton()
    }
}

extension FailAddNewBookViewController: FailAddNewBookViewControllerProtocol {
    func dismissView() {
        dismiss(animated: true, completion: nil)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func loadingAlert() {
        let alert = UIAlertController(title: nil, message: "Загружаем книгу...", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
}
