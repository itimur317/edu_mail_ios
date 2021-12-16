//
//  UserProfileViewController.swift
//  Pickabook
//
//  Created by Даниил Найко on 17.11.2021.
//

import UIKit
import PinLayout

class UserProfileViewController : UIViewController {
    
    func presentProfile(profiles: [Profile]) {}
    func presentAlert(title: String, message: String) {}
    
    var output: UserProfilePresenterProtocol
    let profile: Profile!
    
    init(output: UserProfilePresenterProtocol, profile: Profile){
        self.output = output
        self.profile = profile
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
        view.backgroundColor = .white
        navigationItem.title = "Профиль пользователя"
        
//        back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .black
        
        profileImageView.image = UIImage(named: "default")
        profileImageView.layer.cornerRadius = 60
        profileImageView.layer.masksToBounds = true
        view.addSubview(profileImageView)
        
        profileName.text = profile.name
        profileName.textAlignment = .center
        view.addSubview(profileName)
        
//        profileAboutInfo.text = "Кулинарные книги не предлагать"
//        //profileAboutInfo.textAlignment = .justified // выравнять  по ширине
//        //profileAboutInfo.size
//        profileAboutInfo.textAlignment = .center
//        view.addSubview(profileAboutInfo)
        
        profileMailAdress.text = "peekabook@peeka.book"
        profileMailAdress.font = profileMailAdress.font.withSize(14)
        profileMailAdress.textAlignment = .center
        view.addSubview(profileMailAdress)
        
        profilePhoneNumber.text = "+5 55 55"
        profilePhoneNumber.font = profilePhoneNumber.font.withSize(14)
        profilePhoneNumber.textAlignment = .center
        view.addSubview(profilePhoneNumber)
        
        profileBookListTitle.text = "Книги на обмен"
        view.addSubview(profileBookListTitle)
        
        profileBookListTableView.dataSource = self
        profileBookListTableView.delegate = self
        profileBookListTableView.register(BookTableCell.self, forCellReuseIdentifier: "BookTableCell")
        view.addSubview(profileBookListTableView)
        
        view.addSubview(linksView)
        profileTelegramLinkImageView.image = profileTelegramLinkIcon
        profileInstagramLinkImageView.image = profileInstagramLinkIcon
        linksView.addSubview(profileTelegramLinkImageView)
        linksView.addSubview(profileInstagramLinkImageView)

        
    }
    
    @objc func didTapTelegramLinkButton(_ sender: UIButton) {
        self.output.didTapTelegramLinkButton()
    }
    @objc func didTapInstagramLinkButton(_ sender: UIButton) {
        self.output.didTapInstagramLinkButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
        return profileBookList.count
    }
    //высота строки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableCell", for: indexPath) as? BookTableCell else {
            return .init()
        }
        
        let book = profileBookList[indexPath.row]
        cell.configure(with: book)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = profileBookList[indexPath.row]
        output.didTapOpenBook(book: book)
    }
    
}

extension UserProfileViewController: UserProfileViewControllerProtocol {
    
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
