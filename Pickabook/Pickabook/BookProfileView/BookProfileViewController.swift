//
//  BookProfileViewController.swift
//  Pickabook
//
//  Created by Ульяна Цимбалистая on 04.12.2021.
//

import UIKit
import PinLayout

class BookProfileViewController: UIViewController {
    
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
    
    let scrollView = UIScrollView()
    var stars : [UIButton] = [UIButton]()
    
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
    
    let conditionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.text = "Состояние:"
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    let conditionButton1 : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "conditionStarImage"), for: .normal)
        
        return button
    }()
    
    let conditionButton2 : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "conditionStarImage"), for: .normal)
        
        return button
    }()
    
    let conditionButton3 : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "conditionStarImage"), for: .normal)
        
        return button
    }()
    
    let conditionButton4 : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "conditionStarImage"), for: .normal)
        
        return button
    }()
    
    let conditionButton5 : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "conditionStarImage"), for: .normal)
        
        return button
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
    
    let takeBookButton : UIButton = {
        let button = UIButton()
        button.setTitle("Забрать", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.frame.size = CGSize(width: 200, height: 50)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(named: "buttonColor")
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        setPresenter()
        configureView()
    }
    
    func setPresenter(){
        presenter.setViewDelegate(delegate: self)
    }
    
    func configureView(){
        //надо поменять высоту
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1000)
        view.addSubview(scrollView)
        
        bookImageView.frame.size = CGSize(width: view.frame.width - 30, height: view.frame.width - 30)
        bookImageView.contentMode = UIView.ContentMode.scaleAspectFill
        bookImageView.image = UIImage(data: book.bookImages[0]) ?? UIImage(named: "default")
        scrollView.addSubview(bookImageView)
        
        nameLabel.text = book.bookName
        scrollView.addSubview(nameLabel)
        
        authorLabel.text = book.bookAuthor
        scrollView.addSubview(authorLabel)
        
        genreLabel.text = book.bookGenres.name
        genreLabel.sizeToFit()
        genreLabel.textColor = .white
        genreLabel.backgroundColor = book.bookGenres.color
        scrollView.addSubview(genreLabel)
        
        descriptionLabel.text = book.bookDescription
        descriptionLabel.sizeToFit()
        scrollView.addSubview(descriptionLabel)
        
        scrollView.addSubview(conditionLabel)
        
        stars  = [conditionButton1, conditionButton2, conditionButton3, conditionButton4,  conditionButton5]
        for i in 0...book.bookCondition{
            stars[i].setImage(UIImage(named: "conditionPaintedStarImage"), for: .normal)
        }
        
        for i in 0...4{
            print("ssss")
            scrollView.addSubview(stars[i])
        }
        
        scrollView.addSubview(profileImage)
        // book.owner
        userLabel.text = "Имя пользователя"
        scrollView.addSubview(userLabel)
        
        takeBookButton.addTarget(self,
                                  action: #selector(didTapTakeButton(_:)),
                                  for: .touchUpInside)
        view.addSubview(takeBookButton)
    }
    
    @objc
    private func didTapTakeButton(_ sender: UIButton) {
        presenter.takeBookButtonAction()
    }
    
    func presentNextVC(){
        let presenterB = UserProfilePresenter()
        let vc = UserProfileViewController(output: presenterB)
        self.navigationController?.pushViewController(vc, animated: true)
       
        vc.navigationController?.navigationBar.tintColor = .black
        vc.title = "Обмен с пользователем"
        vc.profileName.text = "Владелец"
        vc.modalPresentationStyle = .fullScreen
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.pin
            .topLeft()
            .height(view.frame.height)
            .width(view.frame.width)
        
        bookImageView.pin
            .top(15)
            .topCenter()
        
        nameLabel.pin
            .below(of: bookImageView)
            .marginTop(3)
            .left(15)
            .right(15)
            .height(25)
        
        authorLabel.pin
            .below(of: nameLabel)
            .marginTop(3)
            .horizontally(15)
            .height(20)
        
        genreLabel.pin
            .below(of: authorLabel)
            .marginTop(10)
            .left(15)
            .width(self.genreLabel.frame.width + 20)
            .height(30)
        
        descriptionLabel.pin
            .below(of: genreLabel)
            .marginTop(10)
            .horizontally(15)
            .height(52)
        
        conditionLabel.pin
            .below(of: descriptionLabel)
            .marginTop(10)
            .left(15)
            .width(100)
            .height(23)
    
        stars[0].pin
            .width(32)
            .after(of: conditionLabel)
            .marginLeft(3)
            .below(of: descriptionLabel)
            .marginTop(5)
            .height(32)
        
        stars[1].pin
            .width(32)
            .after(of: stars[0])
            .marginLeft(3)
            .below(of: descriptionLabel)
            .marginTop(5)
            .height(32)
        
        stars[2].pin
            .width(32)
            .after(of: stars[1])
            .marginLeft(3)
            .below(of: descriptionLabel)
            .marginTop(5)
            .height(32)
        
        stars[3].pin
            .width(32)
            .after(of: stars[2])
            .marginLeft(3)
            .below(of: descriptionLabel)
            .marginTop(5)
            .height(32)
        
        stars[4].pin
            .width(32)
            .after(of: stars[3])
            .marginLeft(3)
            .below(of: descriptionLabel)
            .marginTop(5)
            .height(32)
        
        profileImage.pin
            .below(of: stars[4])
            .marginTop(15)
            .left(15)
        
        userLabel.pin
            .below(of: stars[4])
            .right(of: profileImage)
            .marginTop(20)
            .marginLeft(10)
            .width(self.view.frame.width - 80)
            .height(30)
        
        takeBookButton.pin
            .bottom(94)
            .horizontally((self.view.frame.width - 200)/2)
            .width(200)
    }
}
