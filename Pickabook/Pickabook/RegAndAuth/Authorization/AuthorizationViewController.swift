//
//  AuthorizationViewController.swift
//  Pickabook
//
//  Created by Даниил Найко on 17.11.2021.
//

import UIKit
import PinLayout

class AuthorizationViewController : UIViewController, AuthorizationViewControllerProtocol {

    var output: AuthorizationPresenterProtocol
    init(output: AuthorizationPresenterProtocol){
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
    
    let appIconImage = UIImage(named: "logo") //грузится в низком разрешении, надо править
    let appIconImageView = UIImageView()
    
    let loginLabel = UILabel()
    let loginTextField = UITextField() //надо добавить секурити
    let passwordLabel = UILabel()
    let passwordTextField = UITextField() //надо добавить секурити
    
    let authButton = UIButton()
    let orLabel = UILabel()
    let regButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Авторизация"
        
        self.hideKeyboardWhenTappedAround()
        
        //take 1
        scrollView.contentSize = CGSize(width: view.frame.width, height: 446) // need changes
        view.addSubview(scrollView)
        
//          image
        //appIconImage?.size = 180
        appIconImageView.image = appIconImage
        scrollView.addSubview(appIconImageView)
        
//          labels
        loginLabel.text = "Логин"
        passwordLabel.text = "Пароль"
        [loginLabel, passwordLabel].forEach { label in
            label.font = UIFont.systemFont(ofSize: CGFloat(lableFontSize))
            scrollView.addSubview(label)
        }
        
//          textFields
        loginTextField.text = "login"
        passwordTextField.text = "parol"
        [loginTextField, passwordTextField].forEach { textField in
            textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
            textField.leftViewMode = .always
            textField.layer.cornerRadius = CGFloat(textFieldCornerRadius)
            textField.font = UIFont.systemFont(ofSize: CGFloat(textFieldFontSize))
            //textField.textColor = .black
            textField.backgroundColor = .systemGray6
            scrollView.addSubview(textField)
        }

//        кнопки входа и регистрации
        //seveButton.titleLabel?.font = backButton.titleLabel?.font.withSize(10)
        
        authButton.setTitle("Войти", for: .normal)
        regButton.setTitle("Регистрация", for: .normal)
        [authButton, regButton].forEach() { button in
            button.layer.cornerRadius = 14
            button.layer.masksToBounds = true
            button.backgroundColor = UIColor (
                red: 0.62,
                green: 0.85,
                blue: 0.82,
                alpha: 1.00
            )
            button.setTitleColor(UIColor.black, for: .normal)
            scrollView.addSubview(button)
        }
        
//        лейбл "или"
        orLabel.text = "Нет аккаунта?"
        orLabel.textAlignment = .center
        scrollView.addSubview(orLabel)
        
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
                
        scrollView.pin
            .topLeft()
            .height(view.frame.height)
            .width(view.frame.width)
              
//         image
        appIconImageView.pin
            .top()
            .topCenter()
            .size(180)
        
//        login
        loginLabel.pin
            .below(of: appIconImageView)//.marginTop(10)
            .horizontally(12)
            .height(CGFloat(lableHeight))
        
        loginTextField.pin
            .below(of: loginLabel).marginTop(2)
            .horizontally(12)
            .height(CGFloat(textFieldHeight))
        
//        password
        passwordLabel.pin
            .below(of: loginTextField).marginTop(10)
            .horizontally(12)
            .height(CGFloat(lableHeight))
        
        passwordTextField.pin
            .below(of: passwordLabel).marginTop(2)
            .horizontally(12)
            .height(CGFloat(textFieldHeight))
        
//        кнопка сохранения
        authButton.pin
            .below(of: passwordTextField).marginTop(18)
            .horizontally(12)
            .height(46)
        
//        or label
        orLabel.pin
            .below(of: authButton).marginTop(18)
            .left(12)
            .right(view.frame.width/2+12/2)
            .height(CGFloat(textFieldHeight))

//        кнопка registration
        regButton.pin
            .below(of: authButton).marginTop(18)
            .left(view.frame.width/2+12/2)
            .right(12)
            .height(CGFloat(textFieldHeight))

    }
}

extension AuthorizationViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(AuthorizationViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

    //в мейн вью контроллере
//let authorizationPresenter = AuthorizationPresenter()
//let authorizationViewController = AuthorizationViewController(output: authorizationPresenter)
//let authorizationVC = UINavigationController(rootViewController: authorizationViewController)
//authorizationPresenter.view = authorizationViewController
//authorizationVC.tabBarItem.image = UIImage(named: "AuthorizationViewIcon")
//authorizationVC.title = ""

    //там же поправить
//self.setViewControllers([genresVC, authorizationVC, addVC, myProfileVC], animated: false)
