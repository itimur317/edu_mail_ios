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
    
    let backButton = UIButton()
    let saveUpperButton = UIButton()
    
    let image = UILabel() //= UIImage() //need fix
    let imageEditIcon = UILabel() //= UIImage()
    
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
        self.hideKeyboardWhenTappedAround()
        
        //take 1
        scrollView.contentSize = CGSize(width: view.frame.width, height: 574) // need changes
       
        //take 2
//        scrollView.contentSize = CGSize (
//            width: view.frame.width,
//            height: (
//                CGFloat(view.frame.height) > CGFloat(574) ? view.frame.height : 574
//            )
//        )

        view.addSubview(scrollView)
        
        backButton.setTitle("<", for: .normal)
        //backButton.titleLabel?.font = backButton.titleLabel?.font.withSize(10)
        backButton.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(backButton)
        
        saveUpperButton.setTitle("save", for: .normal)
        //saveUpperButton.titleLabel?.font = saveUpperButton.titleLabel?.font.withSize(10)
        saveUpperButton.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(saveUpperButton)
        
        image.layer.cornerRadius = 60
        image.layer.masksToBounds = true
        image.backgroundColor = UIColor (
            red: 0.62,
            green: 0.85,
            blue: 0.82,
            alpha: 1.00
        )
        scrollView.addSubview(image)
        
        imageEditIcon.layer.cornerRadius = 60
        imageEditIcon.layer.masksToBounds = true
        imageEditIcon.backgroundColor = UIColor (
            red: 0.62,
            green: 0.85,
            blue: 0.82,
            alpha: 1.00
        )
        scrollView.addSubview(imageEditIcon)
        
        nameLabel.text = "Имя"
        emailAdressLabel.text = "Электронная почта"
        phoneNumberLabel.text = "Номер телефона"
        telegramLinkLabel.text = "Ссылка на аккаунт в Telegram"
        instagramLinkLabel.text = "Ссылка на аккаунт в Instagram"
        
//          label parameters
        [nameLabel, emailAdressLabel, phoneNumberLabel, telegramLinkLabel, instagramLinkLabel].forEach { label in
            label.font = UIFont.systemFont(ofSize: CGFloat(lableFontSize))
            scrollView.addSubview(label)
        }
        
        nameTextField.text = "Попуг Олежа"
        emailAdressTextField.text = "peekabook@peeka.book"
        phoneNumberTextField.text = "+4 44 44"
        telegramLinkTextField.text = "https://t.me/"
        instagramLinkTextField.text = "https://www.instagram.com/"
        
//          textField parameters
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
        
//        will be deleted
        backButton.pin
            .top(40)
            .left(12)
            .height(28)
            .width(50)

//        will be deleted
        saveUpperButton.pin
            .top(40)
            .right(12)
            .height(28)
            .width(50)
                
        scrollView.pin
            .topLeft()
            .height(view.frame.height)
            .width(view.frame.width)
                
        image.pin
            .top(12)
            .topCenter()
            .size(120)
        
//        similar to image
        imageEditIcon.pin
            .top(12)
            .topCenter()
            .size(120)
        
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
