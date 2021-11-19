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
    
    let profileImage = UILabel() //let profileImage = UIImage() //need fix
    let profileName = UILabel()
    let profileMailAdress = UILabel()
    let profilePhoneNumber = UILabel()
    let profileBookListTitle = UILabel()
    let profileBookListTableView = UITableView()
    let profileBookList = Util.shared.books
    //let profileAboutInfo = UITextView() //can be added
    //let profileTelegramLink = UIButton() // можно сделать отображение только для других пользователей
    //let profileInstagramLink = UIButton() // можно сделать отображение только для других пользователей
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .black
        
//        title and top right button
        navigationItem.title = "Мой профиль"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(didTapChangeProfileDataButton(_ :))) //old: changeProfileDataButton.addTarget(self, action: #selector(didTapChangeProfileDataButton(_ :)), for: .touchUpInside)
        
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
    
    @objc func didTapChangeProfileDataButton(_ sender: UIButton) {
        self.output.didTapChangeProfileDataButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        profileImage.pin
            .top(50+26)
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
