//
//  MyProfileViewController.swift
//  Pickabook
//
//  Created by Даниил Найко on 08.11.2021.
//

import UIKit
import PinLayout 

//UITableViewDelegate, UITableViewDataSource
class MyProfileViewController : UIViewController, MyProfileViewControllerProtocol {
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

    //    let id: Int
    //    let name: String
    //    let photo: URL?
    //    let about: String?
    //    let phoneNumber: String? //should be changed
    //    let mailAdress: String?
    //    let telegramLink: URL?
    //    let instagramLink: URL?
    //    let bookList: [Book]?
    
    let myProfileTitle = UILabel()
    let changeProfileDataButton = UIButton()
    //let changeProfileDataButton = UIBarButtonItem()
    //let profileImage = UIImage() //need repair
    let profileImage = UILabel()
    //let conditionPaintedStarImage = UIImage(named: "paintedStar")
    let profileName = UILabel()
//    let profileAboutInfo = UITextView()
    let profilePhoneNumber = UILabel()
    let profileMailAdress = UILabel()
    let profileTelegramLink = UIButton() // можно сделать отображение только для других пользователей
    let profileInstagramLink = UIButton() // можно сделать отображение только для других пользователей
    let profileBookListTitle = UILabel()
    let profileBookListTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //title = "Мой профиль"

        myProfileTitle.text = "Мой профиль"
        view.addSubview(myProfileTitle)
        
        changeProfileDataButton.setTitle("edit", for: .normal)
        changeProfileDataButton.backgroundColor = UIColor(red: 0.39, green: 0.42, blue: 0.71, alpha: 1.00)
        changeProfileDataButton.titleLabel?.font = changeProfileDataButton.titleLabel?.font.withSize(10)
        changeProfileDataButton.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(changeProfileDataButton)
        
        //profileImage.imageWithoutBaseline()
        profileImage.layer.cornerRadius = 60
        profileImage.layer.masksToBounds = true
        profileImage.backgroundColor = UIColor(red: 0.62, green: 0.85, blue: 0.82, alpha: 1.00)
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
        //profileMailAdress.size
        profileMailAdress.font = profileMailAdress.font.withSize(14)
        profileMailAdress.textAlignment = .center
        view.addSubview(profileMailAdress)
        
        profilePhoneNumber.text = "+4 44 44"
        profilePhoneNumber.font = profilePhoneNumber.font.withSize(14)
        profilePhoneNumber.textAlignment = .center
        view.addSubview(profilePhoneNumber)
        
        profileBookListTitle.text = "Книги на обмен"
        view.addSubview(profileBookListTitle)
        
        view.addSubview(profileBookListTableView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //it can be added to UInavigationbar (title)
        myProfileTitle.pin
            .top(50)
            .horizontally(12)
            .height(28)
        
        //it can be added to UInavigationbar
        changeProfileDataButton.pin
            .top(50)
            .right(12)
            .size(28)
        
        profileImage.pin
            .below(of: myProfileTitle).marginTop(10)
            .topCenter()
            .size(120)
        //  look at      profileImage.layer.cornerRadius = 60 (120/2)

        profileName.pin
            .below(of: profileImage).marginTop(10)
            .horizontally(12)
            .height(28)
        
//        profileAboutInfo.pin
//            .below(of: profileName).marginTop(0)
//            .horizontally(12)
//            .sizeToFit(.height)
////            .height(50)
        
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
            .below(of: profileBookListTitle)
            .horizontally(12)
            .height(100)
        
    }

}

//extension MyProfileViewController: UITableViewController {
//    private var books: [Book] = []
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            //products = ProductManager.shared.loadProducts()
//            tableView.separatorStyle = .none
//        }
//
//        // MARK: - Table view data source
//        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return books.count
//        }
//
//        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return 120
//        }
//
//        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else {
//                return UITableViewCell()
//            }
//
//            let product = products[indexPath.row]
//            cell.configure(with: product)
//
//            return cell
//        }
//
//        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let product = products[indexPath.row]
//
//            let viewController = ProductViewController()
//            let navigationController = UINavigationController(rootViewController: viewController)
//
//            viewController.product = product
//            viewController.delegate = self
//
//            present(navigationController, animated: true, completion: nil)
//        }
//}
//
//extension MyProfileViewController: ProductViewControllerDelegate {
//    func didTapChatButton(productViewController: UIViewController, productId: String) {
//        productViewController.dismiss(animated: true)
//
//        let alertVC = UIAlertController(title: "Start Chat", message: productId, preferredStyle: .alert)
//        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
//        present(alertVC, animated: true, completion: nil)
//    }
//}
//
    
//    private let tableView: UITableView = {
//        let table = UITableView()
//        table.register(UITableView.self, forCellReuseIdentifier: "cell")
//    }()
//
//    //Table
//    view.addSubview(tableView)
//    tableView.delegate = self
//    tableView.dataSource = self
//
//    //Presenter
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tableView.frame = view.bounds
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        //ask presenter to handle a tap
//    }

