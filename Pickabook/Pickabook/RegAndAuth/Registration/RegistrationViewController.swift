//
//  RegistrationViewController.swift
//  Pickabook
//
//  Created by Даниил Найко on 17.11.2021.
//

import UIKit
import PinLayout
import FirebaseAuth
import FirebaseFirestore

class RegistrationViewController : UIViewController, RegistrationViewControllerProtocol {
    
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
    
    // добавление фото
    let profileImageView = UIImageView()
    
    let addPhotoButton = UIButton()
    let addPhotoImage = UIImage(named: "addPhotoImage")
    let correctPhotoButton = UIButton()
    var addPhotoImagePicker = UIImagePickerController()
    
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
    
    func setImagePicker(){
        addPhotoButton.backgroundColor = UIColor(named: "backgroundColorForEmpty")
        addPhotoButton.layer.cornerRadius = 60
        addPhotoButton.setImage(addPhotoImage, for: .normal)
        addPhotoButton.addTarget(self,
                                 action: #selector(didTapAddPhotoButton(_:)),
                                 for: .touchUpInside)
        scrollView.addSubview(addPhotoButton)
        
        profileImageView.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // presenter delegate
        output.setViewDelegate(delegate: self)
        
        view.backgroundColor = .white
        navigationItem.title = "Регистрация"
        self.hideKeyboardWhenTappedAround()
        
        //take 1
        scrollView.contentSize = CGSize(width: view.frame.width, height: 786) // need changes
        view.addSubview(scrollView)
        
        // image picker
        addPhotoImagePicker.delegate = self
        setImagePicker()

        // labels
        emailAdressLabel.text = "Электронная почта"
        newPasswordFirstLabel.text = "Придумайте пароль"
        newPasswordSecondLabel.text = "Повторите пароль"
        nameLabel.text = "Имя"
        phoneNumberLabel.text = "Номер телефона"
        telegramLinkLabel.text = "Ник в Telegram"
        instagramLinkLabel.text = "Ник в Instagram"
        
        [emailAdressLabel, newPasswordFirstLabel, newPasswordSecondLabel, nameLabel, phoneNumberLabel, telegramLinkLabel, instagramLinkLabel].forEach { label in
            label.font = UIFont.systemFont(ofSize: CGFloat(lableFontSize))
            scrollView.addSubview(label)
        }
        
        //          textFields
        nameTextField.placeholder = "Введите имя"
        nameTextField.autocorrectionType = UITextAutocorrectionType.no
        
        emailAdressTextField.placeholder = "Адрес электронной почты"
        emailAdressTextField.autocorrectionType = UITextAutocorrectionType.no
        emailAdressTextField.keyboardType = UIKeyboardType.emailAddress
        emailAdressTextField.autocapitalizationType = .none
        
        newPasswordFirstTextField.placeholder = "Придумайте пароль"
        newPasswordFirstTextField.isSecureTextEntry = true
        
        newPasswordSecondTextField.placeholder = "Повторите пароль"
        newPasswordSecondTextField.isSecureTextEntry = true
        
        phoneNumberTextField.placeholder = "Введите телефон"
        phoneNumberTextField.keyboardType = UIKeyboardType.phonePad
        phoneNumberTextField.delegate = self
        
        telegramLinkTextField.placeholder = "Ваш ник в Telegram"
        telegramLinkTextField.autocorrectionType = UITextAutocorrectionType.no
        telegramLinkTextField.autocapitalizationType = .none
        
        instagramLinkTextField.placeholder = "Ваш ник в Instagram"
        instagramLinkTextField.autocorrectionType = UITextAutocorrectionType.no
        instagramLinkTextField.autocapitalizationType = .none
        
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
        endRegistrationButton.layer.cornerRadius = 15
        endRegistrationButton.layer.masksToBounds = true
        endRegistrationButton.backgroundColor = UIColor(named: "buttonColor")
        endRegistrationButton.setTitle("Cохранить", for: .normal)
        endRegistrationButton.tintColor = .white
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
        
        addPhotoButton.pin
            .top(10)
            .topCenter()
            .height(120)
            .width(120)
        
        //        имя
        nameLabel.pin
        //.top(12)
            .below(of: addPhotoButton).marginTop(10)
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

//только цифры в номере телефона
extension RegistrationViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

extension RegistrationViewController {
    @objc
    private func didTapSaveButton(_ sender: UIButton) {
        
        guard let email = emailAdressTextField.text,
              let password = newPasswordFirstTextField.text,
              let secPassword = newPasswordSecondTextField.text
        else { return }
        
        //создание ссылок
        var telegramLink = "https://t.me/"
        if telegramLinkTextField.text != "" {
            telegramLink += telegramLinkTextField.text!
            telegramLink = telegramLink.replacingOccurrences(of: " ", with: "")
        } else { telegramLink = "" }
        var instagramLink = "https://www.instagram.com/"
        if instagramLinkTextField.text != "" {
            instagramLink += instagramLinkTextField.text!
            instagramLink = instagramLink.replacingOccurrences(of: " ", with: "")
        } else { instagramLink = "" }
        
        //установка дефолтной картинки, если не выбрана
        var profileImage = profileImageView.image
        if profileImage == nil { profileImage = UIImage(named: "logo") }
        
        func RegAlert (regAlert: String) {
            let alert = UIAlertController(title: "Ошибка", message: regAlert, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
        //проверка корректности введенных данных
        if nameTextField.text == "" {
            RegAlert (regAlert:  "Введите имя пользователя")
        }
        else if emailAdressTextField.text == "" || newPasswordFirstTextField.text == "" || newPasswordSecondTextField.text == "" {
            RegAlert (regAlert:  "Введите почту и/или пароль")
        }
        else if password != secPassword {
            RegAlert (regAlert:  "Пароли не совпадают")
        }
        else if phoneNumberTextField.text == "" && telegramLinkTextField.text == "" && instagramLinkTextField.text == "" {
            RegAlert (regAlert:  "Введите хотя бы один \n способ связи")
        }
        else {
            Auth.auth().createUser(withEmail: email, password: password) { [self] result, error in
                //print("[DEBUG] \(result) \(error)")
                if error == nil { //если нет ошибок
                    //запись в базу данных
                    self.output.didTapRegButton(    name: nameTextField.text!,
                                                    photoName: nil,
                                                    photo: profileImage,
                                                    phoneNumber: phoneNumberTextField.text,
                                                    email: emailAdressTextField.text,
                                                    telegramLink: telegramLink,
                                                    instagramLink: instagramLink )
                    //перенаправление на главный экран с таббаром
                    Coordinator.rootVC( vc: MainViewController() )
                }
                else {
                    RegAlert (regAlert:  "Проверьте правильность \n электронной почты и пароля \n (пароль должен содержать \n хотя бы 6 символов)")
                }
            }
        }
    }
    
    @objc
    private func didTapAddPhotoButton(_ sender: UIButton) {
        self.output.didTapAddPhotoButton()
    }
    
    @objc
    private func didTapCorrectPhotoButton(_ sender: UIButton) {
        
        if profileImageView.image != nil {
            addPhotoButton.isHidden = false
        }
        
        if profileImageView.image != nil {
            profileImageView.image = nil
            profileImageView.isHidden = true
            
            
            correctPhotoButton.isHidden = true
        }
    }
    
    func openSavedPhotosAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            addPhotoImagePicker.allowsEditing = false
            addPhotoImagePicker.sourceType = .savedPhotosAlbum
            
            present(addPhotoImagePicker,
                    animated: true,
                    completion: nil)
        } else {
            let alert = UIAlertController(title: "Нет доступа!",
                                          message: "У Pickabook нет доступа к вашим фото.\nЧтобы предоставить доступ, перейдите в Настройки и включите Фото.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ок",
                                          style: .default,
                                          handler: nil))
            
            present(alert, animated: true)
        }
    }
    
    func setImage(_ pickedImage: UIImage) {
        addPhotoButton.contentMode = .scaleToFill
        addPhotoButton.setImage(pickedImage, for: .normal)
        
        addPhotoButton.layer.cornerRadius = 60
        addPhotoButton.layer.masksToBounds = true
        
        // сохраняем для того, чтобы сохранять в бд
        profileImageView.image = pickedImage
        
        correctPhotoButton.isHidden = false
    }
}

extension RegistrationViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            setImage(pickedImage)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

