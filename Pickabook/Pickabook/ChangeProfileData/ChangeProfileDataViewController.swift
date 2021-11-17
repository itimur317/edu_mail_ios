//
//  ChangeProfileDataViewController.swift
//  Pickabook
//
//  Created by Даниил Найко on 15.11.2021.
//

import UIKit
import PinLayout

class ChangeProfileDataViewController : UIViewController, ChangeProfileDataViewControllerProtocol {

    var output: ChangeProfileDataPresenterProtocol
    init(output: ChangeProfileDataPresenterProtocol){
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//для удобной верстки
    private let lableFontSize = 16
    private let textFieldFontSize = 14
    
    private let lableHeight = 28
    private let textFieldHeight = 32
    
    private let textFieldCornerRadius = 14
//
    let scrollView = UIScrollView()
    
    let image = UILabel() //= UIImage() //need fix
    let imageEditImageView = UIImageView()//= UIButton()
    let imageEditIcon = UIImage(named: "imageEditIcon")
    
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    let emailAdressLabel = UILabel()
    let emailAdressTextField = UITextField()
    let phoneNumberLabel = UILabel()
    let phoneNumberTextField = UITextField()
    let telegramLinkLabel = UILabel()
    let telegramLinkTextField = UITextField()
    let instagramLinkLabel = UILabel()
    let instagramLinkTextField = UITextField()
    
    let seveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Редактировать профиль"
        //self.navigationController.navigationBar.titleTextAttributes = NSFontAttributeName[UIFont.Weight()] // пытался поменять толщину  заголовка, но уже не хочу
        self.hideKeyboardWhenTappedAround()
        
        //take 1
        scrollView.contentSize = CGSize(width: view.frame.width, height: 574) // need changes
        view.addSubview(scrollView)
       
        //take 2
//        scrollView.contentSize = CGSize (
//            width: view.frame.width,
//            height: (
//                CGFloat(view.frame.height) > CGFloat(574) ? view.frame.height : 574
//            )
//        )
//      view.addSubview(scrollView)
        
//          image
        image.layer.cornerRadius = 60
        image.layer.masksToBounds = true
        image.backgroundColor = UIColor (
            red: 0.62,
            green: 0.85,
            blue: 0.82,
            alpha: 1.00
        )
        scrollView.addSubview(image)
                
        imageEditImageView.image = imageEditIcon
        scrollView.addSubview(imageEditImageView)
        
//          labels
        nameLabel.text = "Имя"
        emailAdressLabel.text = "Электронная почта"
        phoneNumberLabel.text = "Номер телефона"
        telegramLinkLabel.text = "Ссылка на аккаунт в Telegram"
        instagramLinkLabel.text = "Ссылка на аккаунт в Instagram"
        
        [nameLabel, emailAdressLabel, phoneNumberLabel, telegramLinkLabel, instagramLinkLabel].forEach { label in
            label.font = UIFont.systemFont(ofSize: CGFloat(lableFontSize))
            scrollView.addSubview(label)
        }
        
//          textFields
        nameTextField.text = "Попуг Олежа"
        emailAdressTextField.text = "peekabook@peeka.book"
        phoneNumberTextField.text = "+4 44 44"
        telegramLinkTextField.text = "https://t.me/"
        instagramLinkTextField.text = "https://www.instagram.com/"
        
        [nameTextField, emailAdressTextField, phoneNumberTextField, telegramLinkTextField, instagramLinkTextField].forEach { textField in
            textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
            textField.leftViewMode = .always
            textField.layer.cornerRadius = CGFloat(textFieldCornerRadius)
            textField.font = UIFont.systemFont(ofSize: CGFloat(textFieldFontSize))
            //textField.textColor = .black
            textField.backgroundColor = .systemGray6
            scrollView.addSubview(textField)
        }

//        кнопка сохранения
        //seveButton.titleLabel?.font = backButton.titleLabel?.font.withSize(10)
        seveButton.layer.cornerRadius = 14
        seveButton.layer.masksToBounds = true
        seveButton.backgroundColor = UIColor (
            red: 0.62,
            green: 0.85,
            blue: 0.82,
            alpha: 1.00
        )
        seveButton.setTitle("Cохранить", for: .normal)
        seveButton.setTitleColor(UIColor.black, for: .normal)
        scrollView.addSubview(seveButton)
        
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
                
        scrollView.pin
            .topLeft()
            .height(view.frame.height)
            .width(view.frame.width)
              
//         image
        image.pin
            .top(12)
            .topCenter()
            .size(120)
        
//        edit icon ( pinned nearly similar to image )
        imageEditImageView.pin
            .top(12+35)
            .topCenter()
            .size(50)
        
//        имя
        nameLabel.pin
            .below(of: image).marginTop(10)
            .horizontally(12)
            .height(CGFloat(lableHeight))
        
        nameTextField.pin
            .below(of: nameLabel).marginTop(2)
            .horizontally(12)
            .height(CGFloat(textFieldHeight))
        
//        почта
        emailAdressLabel.pin
            .below(of: nameTextField).marginTop(10)
            .horizontally(12)
            .height(CGFloat(lableHeight))
        
        emailAdressTextField.pin
            .below(of: emailAdressLabel).marginTop(2)
            .horizontally(12)
            .height(CGFloat(textFieldHeight))
        
//        номер телефона
        phoneNumberLabel.pin
            .below(of: emailAdressTextField).marginTop(10)
            .horizontally(12)
            .height(CGFloat(lableHeight))
        
        phoneNumberTextField.pin
            .below(of: phoneNumberLabel).marginTop(2)
            .horizontally(12)
            .height(CGFloat(textFieldHeight))
        
//        телеграм
        telegramLinkLabel.pin
            .below(of: phoneNumberTextField).marginTop(10)
            .horizontally(12)
            .height(CGFloat(lableHeight))
        
        telegramLinkTextField.pin
            .below(of: telegramLinkLabel).marginTop(2)
            .horizontally(12)
            .height(CGFloat(textFieldHeight))
        
//        инстаграм
        instagramLinkLabel.pin
            .below(of: telegramLinkTextField).marginTop(10)
            .horizontally(12)
            .height(CGFloat(lableHeight))
        
        instagramLinkTextField.pin
            .below(of: instagramLinkLabel).marginTop(2)
            .horizontally(12)
            .height(CGFloat(textFieldHeight))
        
//        кнопка сохранения
        seveButton.pin
            .below(of: instagramLinkTextField).marginTop(18)
            //.bottom(12)
            .horizontally(12)
            .height(46)

    }
}

extension ChangeProfileDataViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChangeProfileDataViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
