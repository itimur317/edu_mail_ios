//
//  RegistrationViewController.swift
//  Pickabook
//
//  Created by Даниил Найко on 17.11.2021.
//

import UIKit
import PinLayout
import Firebase

class RegistrationViewController : UIViewController, RegistrationViewControllerProtocol {

//    var ref: DatabaseReference! //под вопросом
//    private var profileData: Profile! //под вопросом
    
    var output: RegistrationPresenterProtocol
    init(output: RegistrationPresenterProtocol){
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
    
    //email
    let emailAdressLabel = UILabel()
    let emailAdressTextField = UITextField()
    //password
    let newPasswordFirstLabel = UILabel()
    let newPasswordFirstTextField = UITextField()
    let newPasswordSecondLabel = UILabel()
    let newPasswordSecondTextField = UITextField()
    //other
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    let phoneNumberLabel = UILabel()
    let phoneNumberTextField = UITextField()
    let telegramLinkLabel = UILabel()
    let telegramLinkTextField = UITextField()
    let instagramLinkLabel = UILabel()
    let instagramLinkTextField = UITextField()
    
    let generalFirstLabel = UILabel()
    let generalSecondLabel = UILabel()
    let generalThirdLabel = UILabel()
    
    let endRegistrationButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Регистрация"
        self.hideKeyboardWhenTappedAround()
        
        //take 1
        scrollView.contentSize = CGSize(width: view.frame.width, height: 786) // need changes
        view.addSubview(scrollView)
        
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
        
//          labels надо добавить звездочки и обязательные поля
        emailAdressLabel.text = "Электронная почта"
        newPasswordFirstLabel.text = "Придумайте пароль"
        newPasswordSecondLabel.text = "Повторите пароль"
        nameLabel.text = "Имя"
        phoneNumberLabel.text = "Номер телефона"
        telegramLinkLabel.text = "Ссылка на аккаунт в Telegram"
        instagramLinkLabel.text = "Ссылка на аккаунт в Instagram"
        
        [emailAdressLabel, newPasswordFirstLabel, newPasswordSecondLabel, nameLabel, phoneNumberLabel, telegramLinkLabel, instagramLinkLabel].forEach { label in
            label.font = UIFont.systemFont(ofSize: CGFloat(lableFontSize))
            scrollView.addSubview(label)
        }
        
//          textFields
        emailAdressTextField.text = "peekabook@peeka.book"
        newPasswordFirstTextField.text = "parol"
        newPasswordSecondTextField.text = "tochno parol"
        nameTextField.text = "Павлин Кечкa"
        phoneNumberTextField.text = "+4 44 44"
        telegramLinkTextField.text = "https://t.me/"
        instagramLinkTextField.text = "https://www.instagram.com/"
        
        [emailAdressTextField, newPasswordFirstTextField, newPasswordSecondTextField, nameTextField, phoneNumberTextField, telegramLinkTextField, instagramLinkTextField].forEach { textField in
            textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
            textField.leftViewMode = .always
            textField.layer.cornerRadius = CGFloat(textFieldCornerRadius)
            textField.font = UIFont.systemFont(ofSize: CGFloat(textFieldFontSize))
            //textField.textColor = .black
            textField.backgroundColor = .systemGray6
            scrollView.addSubview(textField)
        }

//         главные заголовки
        generalFirstLabel.text = "Данные для регистрации"
        generalSecondLabel.text = "Имя и фото"
        generalThirdLabel.text = "Способы связи"
        [generalFirstLabel, generalSecondLabel, generalThirdLabel].forEach() { label in
            label.font = label.font.withSize(18)
            label.textAlignment = .center
            scrollView.addSubview(label)
        }
        
//        кнопка сохранения
        //saveButton.titleLabel?.font = backButton.titleLabel?.font.withSize(10)
        endRegistrationButton.layer.cornerRadius = 14
        endRegistrationButton.layer.masksToBounds = true
        endRegistrationButton.backgroundColor = UIColor (
            red: 0.62,
            green: 0.85,
            blue: 0.82,
            alpha: 1.00
        )
        endRegistrationButton.setTitle("Cохранить", for: .normal)
        endRegistrationButton.setTitleColor(UIColor.black, for: .normal)
        endRegistrationButton.addTarget(self,
                            action: #selector(didTapSaveButton(_:)),
                            for: .touchUpInside)
        scrollView.addSubview(endRegistrationButton)
        
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
            //.top(12)
            .below(of: image).marginTop(10)
            .horizontally(12)
            .height(CGFloat(lableHeight))
        
        nameTextField.pin
            .below(of: nameLabel).marginTop(2)
            .horizontally(12)
            .height(CGFloat(textFieldHeight))
        
//          first BIG label
        generalFirstLabel.pin
            .below(of: nameTextField).marginTop(14) //was 10
            .horizontally(12)
            .height(CGFloat(lableHeight))
        
//          email
        emailAdressLabel.pin
            .below(of: generalFirstLabel).marginTop(2)
            .horizontally(12)
            .height(CGFloat(lableHeight))
        
        emailAdressTextField.pin
            .below(of: emailAdressLabel).marginTop(2)
            .horizontally(12)
            .height(CGFloat(textFieldHeight))
        
//          new password
        newPasswordFirstLabel.pin
            .below(of: emailAdressTextField).marginTop(10)
            .horizontally(12)
            .height(CGFloat(lableHeight))
        
        newPasswordFirstTextField.pin
            .below(of: newPasswordFirstLabel).marginTop(2)
            .horizontally(12)
            .height(CGFloat(textFieldHeight))
        
        newPasswordSecondLabel.pin
            .below(of: newPasswordFirstTextField).marginTop(10)
            .horizontally(12)
            .height(CGFloat(lableHeight))
        
        newPasswordSecondTextField.pin
            .below(of: newPasswordSecondLabel).marginTop(2)
            .horizontally(12)
            .height(CGFloat(textFieldHeight))

//          third BOG label
        generalThirdLabel.pin
            .below(of: newPasswordSecondTextField).marginTop(14)
            .horizontally(12)
            .height(CGFloat(lableHeight))
        
//        номер телефона
        phoneNumberLabel.pin
            .below(of: generalThirdLabel).marginTop(2)
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
        endRegistrationButton.pin
            .below(of: instagramLinkTextField).marginTop(18)
            .horizontally(12)
            .height(46)

    }
//
//
//    func createProfile(profile: Profile, password: String) {
//            Auth.auth().createUser(withEmail: profile.email, password: password, completion: {(result, error) in
//                guard error == nil else {
//                    print("error registration: \(error!)")
//                    return
//                }
//                print("You have signed in")
//                self.createProfileData(profile: profile)
//            })
//        }
//
//    func createProfileData(profile: Profile){
//            //guard let currentProfile = Auth.auth().currentUser else { return }
//            //self.profile = Profile(profile: currentProfile)
//            ref = Database.database().reference(withPath: "profiles")
//            self.profileData = profile
//            //imageUpload(image: userData.profileImage!, title: "profile image")
//        }
//
//
}

extension RegistrationViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegistrationViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension RegistrationViewController {
    @objc
    private func didTapSaveButton(_ sender: UIButton) {
        guard let email = emailAdressTextField.text
        else {
            return
        }
       
        guard let password = newPasswordFirstTextField.text
        else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            print("[DEBUG] \(result) \(error)")
        }
        //надо перенаправить на главный экран с таббаром
    }
}

// mainVC
//let registrationPresenter = RegistrationPresenter()
//let registrationViewController = RegistrationViewController(output: registrationPresenter)
//let registrationVC = UINavigationController(rootViewController: registrationViewController)
//registrationPresenter.view = registrationViewController
//registrationVC.tabBarItem.image = UIImage(named: "RegistrationViewIcon")
//registrationVC.title = ""
//
//self.setViewControllers([genresVC, registrationVC, addVC, myProfileVC], animated: false)

