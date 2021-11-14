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
    
    //let conditionPaintedStarImage = UIImage(named: "paintedStar") //example
    let myProfileTitle = UILabel()
    let changeProfileDataButton = UIButton() //let changeProfileDataButton = UIBarButtonItem() //can be upgraded
    let profileImage = UILabel() //let profileImage = UIImage() //need repair
    let profileName = UILabel()
    //let profileAboutInfo = UITextView()
    let profilePhoneNumber = UILabel()
    let profileMailAdress = UILabel()
    let profileTelegramLink = UIButton() // можно сделать отображение только для других пользователей
    let profileInstagramLink = UIButton() // можно сделать отображение только для других пользователей
    let profileBookListTitle = UILabel()
    let profileBookListTableView = UITableView()
    let profileBookList: [Book] = [Book(bookImages: [], bookName: "Преступление и наказание", bookAuthor: "Ф.М. Достоевский", bookGenreId: 1, bookCondition: 4, bookDescription: "слдтвлс", bookLanguage: "ьдылвсы"), Book(bookImages: [], bookName: "Кулинарная книга", bookAuthor: "Народов Кавказа", bookGenreId: 1, bookCondition: 4, bookDescription: "[pqk", bookLanguage: "fkejbowj"),Book(bookImages: [], bookName: "Моя биография", bookAuthor: "Неизветный автор", bookGenreId: 1, bookCondition: 4, bookDescription: "[pqk", bookLanguage: "fkejbowj"),Book(bookImages: [], bookName: "Календарь за 1956 год", bookAuthor: "ГКСП имени В.И. Ленина", bookGenreId: 1, bookCondition: 4, bookDescription: "[pqk", bookLanguage: "fkejbowj"),Book(bookImages: [], bookName: "Ну зачем долистал сюда", bookAuthor: "Конец  списка", bookGenreId: 1, bookCondition: 4, bookDescription: "[pqk", bookLanguage: "fkejbowj")]
     
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.delegate = self
        //tableView.dataSource = self
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
        profileMailAdress.font = profileMailAdress.font.withSize(14)
        profileMailAdress.textAlignment = .center
        view.addSubview(profileMailAdress)
        
        profilePhoneNumber.text = "+4 44 44"
        profilePhoneNumber.font = profilePhoneNumber.font.withSize(14)
        profilePhoneNumber.textAlignment = .center
        view.addSubview(profilePhoneNumber)
        
        profileBookListTitle.text = "Книги на обмен"
        view.addSubview(profileBookListTitle)
        
        //profileBookListTableView.backgroundColor = UIColor(red: 0.71, green: 0.75, blue: 0.93, alpha: 1.00)
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
////            .sizeToFit(.height)
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
    //количество столбцов
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileBookList.count
    }
    //высота столбца
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

//extension MyProfileViewController: UITableViewController {
//    private var books: [Book] = []
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            //products = ProductManager.shared.loadProducts()
//            tableView.separatorStyle = .none
//        }
//

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
