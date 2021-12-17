//
//  UserProfileViewController.swift
//  Pickabook
//
//  Created by Даниил Найко on 17.11.2021.
//
import UIKit
import PinLayout
import Firebase

class UserProfileViewController : UIViewController {
    
    //func presentProfile(profiles: [Profile]) {}
    func presentAlert(title: String, message: String) {}
    
    var output: UserProfilePresenterProtocol
    var userProfile: Profile!
    var telegramUrl: URL? //= URL(string: "")!
    var instagramUrl: URL? //= URL(string: "")!
    var userId: String
    
    init(output: UserProfilePresenterProtocol, userId: String){
        self.output = output
        self.userId = userId
        self.telegramUrl = URL(string: "")
        self.instagramUrl = URL(string: "")
        //self.userProfile = profile
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let profileImageView = UIImageView()
    let profileName = UILabel()
    let profileMailAdress = UILabel()
    let profilePhoneNumber = UILabel()
    let profileBookListTitle = UILabel()
    let profileBookListTableView = UITableView()
    let profileBookList = books
    //let profileAboutInfo = UITextView() //can be added
    let linksView = UIView()
    let profileTelegramLinkIcon = UIImage(named: "telegramIcon")
    let profileInstagramLinkIcon = UIImage(named: "instagramIcon")
    let profileTelegramLinkImageView = UIImageView()
    let profileInstagramLinkImageView = UIImageView()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        output.setViewDelegate(delegate: self)
        
        let telegramTapGesture = UITapGestureRecognizer(target: self, action: #selector(UserProfileViewController.telegramImageTapped(gesture: )))
        let instagramTapGesture = UITapGestureRecognizer(target: self, action: #selector(UserProfileViewController.instagramImageTapped(gesture: )))
        
        view.backgroundColor = .white
        navigationItem.title = "Профиль пользователя"
        
//        back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .black
        
        //фото профиля
        profileImageView.image = UIImage(named: "default")
        profileImageView.layer.cornerRadius = 60
        profileImageView.layer.masksToBounds = true
        view.addSubview(profileImageView)
        
        //имя в профиле
        profileName.text = "Попуг Геночка"
        profileName.textAlignment = .center
        view.addSubview(profileName)
        
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
        profilePhoneNumber.text = "+5 55 55"
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
        
        //блок ссылок
        view.addSubview(linksView)
        profileTelegramLinkImageView.image = profileTelegramLinkIcon
        profileInstagramLinkImageView.image = profileInstagramLinkIcon
        linksView.addSubview(profileTelegramLinkImageView)
        linksView.addSubview(profileInstagramLinkImageView)
        
        //распознание нажатий
        profileTelegramLinkImageView.addGestureRecognizer(telegramTapGesture)
        profileInstagramLinkImageView.addGestureRecognizer(instagramTapGesture)

        profileTelegramLinkImageView.isUserInteractionEnabled = true
        profileInstagramLinkImageView.isUserInteractionEnabled = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.output.observeBooks(userId: userId)
        self.output.observeUserProfile(userId: userId)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //updateLayout()
    }
    
    func updateLayout() {
        
        profileImageView.pin
            .top(view.pin.safeArea.top+12)
            //.below(of: UserProfileTitle).marginTop(10)
            //.top(50+26)
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
        
        linksView.pin
            .below(of: profilePhoneNumber).marginTop(10)
            .topCenter()
            .width(100)
            .height(36)
        
            profileTelegramLinkImageView.pin
                .top(0)
                .left(0)
                .size(linksView.frame.height)
            
            profileInstagramLinkImageView.pin
                .top(0)
                .right(0)
                .size(linksView.frame.height)
        
        profileBookListTitle.pin
            .below(of: linksView).marginTop(12)
            .horizontally(12)
            .height(28)
        
        profileBookListTableView.pin
            .below(of: profileBookListTitle).marginTop(3)
            .horizontally(12)
            .bottom(12)
        
    }

}

extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource {
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
        
        let book = self.output.currentBooks[indexPath.row]
        cell.configure(with: book)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = self.output.currentBooks[indexPath.row]
        output.didTapOpenBook(book: book)
    }
    
}

extension UserProfileViewController {
    @objc func didTapTelegramLinkButton(_ sender: UIButton) {
        self.output.didTapTelegramLinkButton()
    }
    @objc func didTapInstagramLinkButton(_ sender: UIButton) {
        self.output.didTapInstagramLinkButton()
    }
}

extension UserProfileViewController: UserProfileViewControllerProtocol {
    
    func reloadUserProfile(userProfile: Profile) {
        self.userProfile = userProfile
        
        profileImageView.image = userProfile.photo        //UIImage(named: "default")
        profileName.text = userProfile.name               //"Попуг Олежа"
        profileMailAdress.text = userProfile.email        //"peekabook@peeka.book"
        profilePhoneNumber.text = userProfile.phoneNumber
        
        let telLink = userProfile.telegramLink ?? ""
        telegramUrl = URL(string: telLink)
        let instLink = userProfile.instagramLink ?? ""
        instagramUrl = URL(string: instLink)
        
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
    
    func openBook(book: Book) {
        let bookViewPresenter = BookViewPresenter()
        let bookProfileViewController = BookProfileViewController(output: bookViewPresenter, book: book, owned: true)
        navigationController?.pushViewController(bookProfileViewController, animated: true)
        //bookViewPresenter.view = bookProfileViewController
    }

}

extension UserProfileViewController {
    @objc func telegramImageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            print("Telegram Image Tapped")
            print(telegramUrl)
            UIApplication.shared.open(telegramUrl!)
        }
    }
    
    @objc func instagramImageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            print("Instagram Image Tapped")
            print(instagramUrl)
            UIApplication.shared.open(instagramUrl!)
        }
    }
}
