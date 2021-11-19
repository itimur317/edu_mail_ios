//
//  MyProfileViewController.swift
//  Pickabook
//
//  Created by Даниил Найко on 08.11.2021.
//

import UIKit
import PinLayout 

class MyProfileViewController : UIViewController {
    
    func presentProfile(profiles: [Profile]) {}
    func presentAlert(title: String, message: String) {}
    
    var output: MyProfilePresenterProtocol
    init(output: MyProfilePresenterProtocol){
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //example //let Image = UIImage(named: "nameOfImage")
    let myProfileTitle = UILabel()
    let changeProfileDataButton = UIButton() //let changeProfileDataButton = UIBarButtonItem() //can be upgraded
    let profileImage = UILabel() //let profileImage = UIImage() //need fix
    let profileName = UILabel()
    //let profileAboutInfo = UITextView() //can be added
    let profileMailAdress = UILabel()
    let profilePhoneNumber = UILabel()
    //let profileTelegramLink = UIButton() // можно сделать отображение только для других пользователей
    //let profileInstagramLink = UIButton() // можно сделать отображение только для других пользователей
    let profileBookListTitle = UILabel()
    let profileBookListTableView = UITableView()
    
    let profileBookList = Util.shared.books
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        changeProfileDataButton.addTarget(self, action: #selector(didTapChangeProfileDataButton(_ :)), for: .touchUpInside)
        changeProfileDataButton.layer.cornerRadius = 10
        changeProfileDataButton.layer.masksToBounds = true
        changeProfileDataButton.setTitle("edit", for: .normal)
        changeProfileDataButton.backgroundColor = UIColor (
            red: 0.39,
            green: 0.42,
            blue: 0.71,
            alpha: 1.00
        )
        changeProfileDataButton.titleLabel?.font = changeProfileDataButton.titleLabel?.font.withSize(10)
        changeProfileDataButton.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(changeProfileDataButton)
        
        //profileImage.imageWithoutBaseline()
        profileImage.layer.cornerRadius = 60
        profileImage.layer.masksToBounds = true
        profileImage.backgroundColor = UIColor (
            red: 0.62,
            green: 0.85,
            blue: 0.82,
            alpha: 1.00
        )
        view.addSubview(profileImage)
        
        profileName.text = "Попуг Олежа"
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
        
        profilePhoneNumber.text = "+4 44 44"
        profilePhoneNumber.font = profilePhoneNumber.font.withSize(14)
        profilePhoneNumber.textAlignment = .center
        view.addSubview(profilePhoneNumber)
        
        profileBookListTitle.text = "Книги на обмен"
        view.addSubview(profileBookListTitle)
        
        profileBookListTableView.dataSource = self
        profileBookListTableView.delegate = self
        profileBookListTableView.register(BookListTableViewCell.self, forCellReuseIdentifier: "BookListTableViewCell")
        view.addSubview(profileBookListTableView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        myProfileTitle.pin  //it can be added to UInavigationbar (title)
            .top(50)
            .horizontally(12)
            .height(28)
        
        changeProfileDataButton.pin //it can be added to UInavigationbar
            .top(50)
            .right(12)
            .size(28)
        
        profileImage.pin
            .below(of: myProfileTitle).marginTop(10)
            .topCenter()
            .size(120) //  look at profileImage.layer.cornerRadius = 60 (=120/2)

        profileName.pin
            .below(of: profileImage).marginTop(10)
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
    
    @objc func didTapChangeProfileDataButton(_ sender: UIButton) {
        self.output.didTapChangeProfileDataButton()
    }

}

extension MyProfileViewController: UITableViewDelegate, UITableViewDataSource {
    //количество строк
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileBookList.count
    }
    //высота строки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookListTableViewCell", for: indexPath) as? BookListTableViewCell else {
            return .init()
        }
        
        let book = profileBookList[indexPath.row]
        cell.configure(with: book)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
}

extension MyProfileViewController: MyProfileViewControllerProtocol {
    
    func changeProfileDataView() {
        let changeProfileDataPresenter = ChangeProfileDataPresenter()
        let changeProfileDataViewController = ChangeProfileDataViewController(output: changeProfileDataPresenter)
        navigationController?.pushViewController(changeProfileDataViewController, animated: true)
        changeProfileDataPresenter.view = changeProfileDataViewController
    }
    
}
