//
//  AuthorizationViewController.swift
//  Pickabook
//
//  Created by Даниил Найко on 17.11.2021.
//

import UIKit
import PinLayout
import FirebaseAuth

class AuthorizationViewController : UIViewController {

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
    
    let appIconImage = UIImage(named: "logo")
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
        
        //back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .black
        
        self.hideKeyboardWhenTappedAround()
        
        //take 1
        scrollView.contentSize = CGSize(width: view.frame.width, height: 446 /*+ 500*/) // need changes
        view.addSubview(scrollView)
        
//          image
        //appIconImage?.size = 180
        appIconImageView.image = appIconImage
        scrollView.addSubview(appIconImageView)
        
//          labels
        loginLabel.text = "Электронная почта"
        passwordLabel.text = "Пароль"
        [loginLabel, passwordLabel].forEach { label in
            label.font = UIFont.systemFont(ofSize: CGFloat(lableFontSize))
            scrollView.addSubview(label)
        }
        
//          textFields
        loginTextField.placeholder = "Адрес электронной почты"
        loginTextField.keyboardType = UIKeyboardType.emailAddress
        loginTextField.autocorrectionType = UITextAutocorrectionType.no
        loginTextField.autocapitalizationType = .none
        
        passwordTextField.placeholder = "Введите пароль"
        passwordTextField.isSecureTextEntry = true

        
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
        
        authButton.addTarget(self,
                             action: #selector(didTapAuthButton(_:)),
                             for: .touchUpInside)
        regButton.addTarget(self,
                            action: #selector(didTapRegButton(_:)),
                            for: .touchUpInside)
        
        [authButton, regButton].forEach() { button in
            button.layer.cornerRadius = 15
            button.layer.masksToBounds = true
            button.backgroundColor = UIColor(named: "buttonColor")
            button.setTitleColor(UIColor.white, for: .normal)
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
            .top(view.pin.safeArea.top)
            .width(view.frame.width)
            .bottom(view.pin.safeArea.bottom)
              
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

extension AuthorizationViewController: AuthorizationViewControllerProtocol {
    func regTapped() {
        let regPresenter = RegistrationPresenter()
        let regViewController = RegistrationViewController(output: regPresenter)
        navigationController?.pushViewController(regViewController, animated: true)
    }
    
    @objc func didTapRegButton(_ sender: UIButton) {
        self.output.didTapRegButton()
        print ("boom")
    }
}

extension AuthorizationViewController {
    @objc
    private func didTapAuthButton(_ sender: UIButton) {
       
        guard let email = loginTextField.text,
              let password = passwordTextField.text
        else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            print("[DEBUG] \(result) \(error)")
            if error == nil {
                //перенаправление на главный экран с таббаром
                Coordinator.rootVC(vc: MainViewController() )
            }
            else {
                let alert = UIAlertController(title: "Ошибка", message: "Проверьте правильность \n введенных данных", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
        
        //перенаправление на главный экран с таббаром
        //Coordinator.rootVC(vc: MainViewController() )
        //navigationController?.pushViewController(mainViewController, animated: true)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        if Auth.auth().currentUser?.isAnonymous != nil {
//                self.navigationController?.isNavigationBarHidden = true
//        }
//    }
}

//extension AuthorizationViewController: AuthorizationViewControllerProtocol {
//    func redirectToMain() {
//        let mainViewController = MainViewController
//        navigationController?.pushViewController(mainViewController, animated: true)
//    }
//    
//    @objc func loginRedirect() {
//        self.output.loginRedirect()
//    }
//}

    //в мейн вью контроллере
//let authorizationPresenter = AuthorizationPresenter()
//let authorizationViewController = AuthorizationViewController(output: authorizationPresenter)
//let authorizationVC = UINavigationController(rootViewController: authorizationViewController)
//authorizationPresenter.view = authorizationViewController
//authorizationVC.tabBarItem.image = UIImage(named: "AddViewIcon")
//authorizationVC.title = ""

    //там же поправить
//self.setViewControllers([authorizationVC, genresVC, libraryVC, myProfileVC], animated: false)
