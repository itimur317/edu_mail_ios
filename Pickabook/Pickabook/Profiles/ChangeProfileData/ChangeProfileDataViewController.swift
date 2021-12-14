//
//  ChangeProfileDataViewController.swift
//  Pickabook
//
//  Created by Даниил Найко on 15.11.2021.
//

import UIKit
import PinLayout
import FirebaseAuth

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
    
    // добавление фото
    let profileImageView = UIImageView()
    
    let addPhotoButton = UIButton()
    let addPhotoImage = UIImage(named: "addPhotoImage")
    let correctPhotoButton = UIButton()
    var addPhotoImagePicker = UIImagePickerController()
    
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
    
    let saveButton = UIButton()
    
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
        navigationItem.title = "Изменить профиль"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action: #selector(didTapLogoutButton(_ :)))
        //self.navigationController.navigationBar.titleTextAttributes = NSFontAttributeName[UIFont.Weight()] // пытался поменять толщину  заголовка, но уже не хочу
        self.hideKeyboardWhenTappedAround()
        
        //take 1
        scrollView.contentSize = CGSize(width: view.frame.width, height: 578) // need changes
        view.addSubview(scrollView)
       
        // image picker
        addPhotoImagePicker.delegate = self
        setImagePicker()
        
        //take 2
//        scrollView.contentSize = CGSize (
//            width: view.frame.width,
//            height: (
//                CGFloat(view.frame.height) > CGFloat(574) ? view.frame.height : 574
//            )
//        )
//      view.addSubview(scrollView)

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
        //saveButton.titleLabel?.font = backButton.titleLabel?.font.withSize(10)
        saveButton.layer.cornerRadius = 14
        saveButton.layer.masksToBounds = true
        saveButton.backgroundColor = UIColor(named: "buttonColor")
        saveButton.setTitle("Cохранить", for: .normal)
        saveButton.setTitleColor(UIColor.white, for: .normal)
        scrollView.addSubview(saveButton)
        
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
                
        scrollView.pin
            .topLeft()
            .height(view.frame.height)
            .width(view.frame.width)
              
        addPhotoButton.pin
            .top(12)
            .topCenter()
            .height(120)
            .width(120)
        
//        имя
        nameLabel.pin
            .below(of: addPhotoButton).marginTop(10)
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
        saveButton.pin
            .below(of: instagramLinkTextField).marginTop(18)
            //.bottom(12)
            .width(200)
            .height(50)
            .left(view.frame.width / 2 - 100)

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

extension ChangeProfileDataViewController {
    @objc private func didTapLogoutButton(_ sender: UIButton) {
        //разлогинься
        try? Auth.auth().signOut()
        //перенаправление на экран авторизации
        let authorizationPresenter = AuthorizationPresenter()
        let authorizationViewController = AuthorizationViewController(output: authorizationPresenter)
        Coordinator.rootVC(vc: authorizationViewController)
        //navigationController?.pushViewController(authorizationViewController, animated: true)
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

extension ChangeProfileDataViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
