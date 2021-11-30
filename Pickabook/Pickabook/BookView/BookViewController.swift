//
//  BookView.swift
//  Pickabook
//
//  Created by Ульяна Цимбалистая on 27.11.2021.
//

import UIKit
import PinLayout

class BookViewController: UIViewController {
    var presenter: BookViewPresenterProtocol!
    let book : Book!
    
    init(output: BookViewPresenterProtocol, book: Book){
        self.presenter = output
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let bookImageView : UIImageView = {
        let image = UIImage(named: "default")
        let imageView = UIImageView(image: image)
        
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
        
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21, weight: .regular)
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    let authorLabel :  UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    let genreLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    let profileImage : UIImageView = {
        let image = UIImage(named: "default")
        let imageView = UIImageView(image: image)
        imageView.frame.size = CGSize(width: 50, height: 50)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 25
        
        return imageView
    }()
    
    let userLabel :  UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(didTapHeartButton(_ :)))
        
        configureView()
    }
    
    func configureView(){
        bookImageView.frame.size = CGSize(width: view.frame.width - 30, height: 250)
        view.addSubview(bookImageView)
        
        nameLabel.text = book.bookName
        view.addSubview(nameLabel)
        
        authorLabel.text = book.bookAuthor
        view.addSubview(authorLabel)
        
        genreLabel.text = "жанр"
        genreLabel.backgroundColor = UIColor(red: 1.00, green: 0.89, blue: 0.37, alpha: 1.00)
        view.addSubview(genreLabel)
        
        descriptionLabel.text = book.bookDescription
        view.addSubview(descriptionLabel)
        
        view.addSubview(profileImage)
        
        userLabel.text = "Имя пользователя"
        view.addSubview(userLabel)
    }
    
    @objc func didTapHeartButton(_ sender: UIButton) {
        self.presenter.heartButtonAction()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bookImageView.pin
            .top(70+26)
            .topCenter()
        
        nameLabel.pin
            .below(of: bookImageView)
            .left(15)
            .right(15)
            .height(25)
        
        authorLabel.pin
            .below(of: nameLabel)
            .horizontally(15)
            .height(20)
        
        genreLabel.pin
            .below(of: authorLabel)
            .marginTop(5)
            .horizontally(15)
            .width(70)
            .height(25)
        
        descriptionLabel.pin
            .below(of: genreLabel)
            .horizontally(15)
            .height(70)
        
        profileImage.pin
            .below(of: descriptionLabel)
            .left(15)
        
        userLabel.pin
            .below(of: descriptionLabel)
            .right(of: profileImage)
            .marginTop(10)
            .marginLeft(10)
            .width(self.view.frame.width - 80)
            .height(30)
    }
}
