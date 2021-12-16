//
//  MyProfileViewController.swift
//  Pickabook
//
//  Created by Даниил Найко on 08.11.2021.
//
import UIKit
import PinLayout
import Firebase

class MyProfileViewController : UIViewController {
    
    //func presentProfile(profiles: [Profile]) {}
    func presentAlert(title: String, message: String) {}
    
    var output: MyProfilePresenterProtocol
    var myProfile: Profile!

    init(output: MyProfilePresenterProtocol/*, myProfile: Profile*/){
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    var handle: AuthStateDidChangeListenerHandle?
    let profileImageView = UIImageView()
    
    let profileName = UILabel()
    let profileMailAdress = UILabel()
    let profilePhoneNumber = UILabel()
    let profileBookListTitle = UILabel()
    let profileBookListTableView = UITableView()
    let profileBookList = books

    //let profileTelegramLink = UIButton() // можно сделать отображение только для других пользователей
    //let profileInstagramLink = UIButton() // можно сделать отображение только для других пользователей
    //let profileAboutInfo = UITextView() //can be added
    //let profileTelegramLink = UIButton() // можно сделать отображение только для других пользователей
    //let profileInstagramLink = UIButton() // можно сделать отображение только для других пользователей
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // presenter delegate
        output.setViewDelegate(delegate: self)
        
        view.backgroundColor = .white
//        back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .black
        
//        title and top right button
        navigationItem.title = "Мой профиль"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(didTapChangeProfileDataButton(_ :)))
        
        //фото профиля
        profileImageView.image = UIImage(named: "default")
        profileImageView.layer.cornerRadius = 60
        profileImageView.layer.masksToBounds = true
        view.addSubview(profileImageView)
        
        //имя в профиле
        profileName.text = "Попуг Олежа"
        profileName.textAlignment = .center
        view.addSubview(profileName)
        
        //описание профиля
//        profileAboutInfo.text = "Кулинарные книги не предлагать"
//        //profileAboutInfo.textAlignment = .justified // выравнять  по ширине
//        //profileAboutInfo.size
//        profileAboutInfo.textAlignment = .center
//        view.addSubview(profileAboutInfo)
        
        //почта
        profileMailAdress.text = "peekabook@peeka.book"
        profileMailAdress.font = profileMailAdress.font.withSize(14)
        profileMailAdress.textAlignment = .center
        view.addSubview(profileMailAdress)
        
        //телефон
        profilePhoneNumber.text = "+4 44 44"
        profilePhoneNumber.font = profilePhoneNumber.font.withSize(14)
        profilePhoneNumber.textAlignment = .center
        view.addSubview(profilePhoneNumber)
        
        //заголовок
        profileBookListTitle.text = "Книги на обмен"
        view.addSubview(profileBookListTitle)
        
        //таблица с ячейками книг
        profileBookListTableView.dataSource = self
        profileBookListTableView.delegate = self
        profileBookListTableView.register(BookTableCell.self, forCellReuseIdentifier: "BookTableCell")
        view.addSubview(profileBookListTableView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.output.observeBooks()
        self.output.observeMyProfile()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //updateLayout()
    }
    
    func updateLayout() {
        
        profileImageView.pin
            .top(view.pin.safeArea.top + 12)
            .topCenter()
            .size(120) //  look at profileImage.layer.cornerRadius = 60 (=120/2)
        
        profileName.pin
            .below(of: profileImageView).marginTop(10)
            .horizontally(12)
            .height(28)
        
//        profileAboutInfo.pin
//            .below(of: profileName).marginTop(0)
//            .horizontally(12)
//            .height(50)
        
        profileMailAdress.pin
            .below(of: profileName).marginTop(-4)
            .horizontally(12)
            .height(28)
        
        profilePhoneNumber.pin
            .below(of: profileMailAdress).marginTop(-12)
            .horizontally(12)
            .height(28)
        
        profileBookListTitle.pin
            .below(of: profilePhoneNumber)
            .horizontally(12)
            .height(28)
        
        profileBookListTableView.pin
            .below(of: profileBookListTitle).marginTop(3)
            .horizontally(12)
            .bottom(12)
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        handle = Auth.auth().addStateDidChangeListener { auth, user in
//          // ...
//        }
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        Auth.auth().removeStateDidChangeListener(handle!)
//    }

}

extension MyProfileViewController: UITableViewDelegate, UITableViewDataSource {
    //количество строк
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.output.currentBooks.count
    }
    //высота строки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableCell", for: indexPath) as? BookTableCell else {
            return .init()
        }
        
//        let book = profileBookList[indexPath.row]
        let book = self.output.currentBooks[indexPath.row]
        cell.configure(with: book)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let book = profileBookList[indexPath.row]
        let book = self.output.currentBooks[indexPath.row]
        output.didTapOpenBook(book: book)
    }
    
}

extension MyProfileViewController: MyProfileViewControllerProtocol {
    
    func reloadMyProfile(myProfile: Profile) {
        self.myProfile = myProfile
        
        profileImageView.image = myProfile.photo        //UIImage(named: "default")
        profileName.text = myProfile.name               //"Попуг Олежа"
        profileMailAdress.text = myProfile.email        //"peekabook@peeka.book"
        //let phoneNumber = myProfile.phoneNumber!
        //profilePhoneNumber.text = String(phoneNumber) //"+4 44 44"
        profilePhoneNumber.text = myProfile.phoneNumber
        
        updateLayout()
    }
    
    func reloadTable() {
        self.profileBookListTableView.reloadData()
    }
    
   
    func changeProfileDataView() {
        let changeProfileDataPresenter = ChangeProfileDataPresenter()
        let changeProfileDataViewController = ChangeProfileDataViewController(output: changeProfileDataPresenter)
        navigationController?.pushViewController(changeProfileDataViewController, animated: true)
        changeProfileDataPresenter.view = changeProfileDataViewController
    }
    
    @objc func didTapChangeProfileDataButton(_ sender: UIButton) {
        self.output.didTapChangeProfileDataButton()
    }
    
    func openBook(book: Book) {
        let bookViewPresenter = BookViewPresenter()
        let bookProfileViewController = BookProfileViewController(output: bookViewPresenter, book: book, owned: true)
        navigationController?.pushViewController(bookProfileViewController, animated: true)
        //bookViewPresenter.view = bookProfileViewController
    }
    
//    func loadProfileData(profileData: Profile) { }
}

//extension MyProfileViewController : UserManagerOutput {
//    
//    func didRecieve(_ user: Profile) { }
//    func didCreate(_ user: Profile) { }
//    func didFail(with error: Error) { }
//    
//    UserManager.shared.getMyProfileData() 
//}
