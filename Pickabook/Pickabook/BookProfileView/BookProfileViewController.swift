//
//  BookProfileViewController.swift
//  Pickabook
//
//  Created by Ульяна Цимбалистая on 04.12.2021.
//
import UIKit
import PinLayout

class BookProfileViewController: UIViewController {
    /* Presenter книги, отвечает за логику */
    var presenter: BookViewPresenterProtocol!
    /* Экземпляр книги которой заполняется страница */
    let book : Book!
    /* Флаг, чтобы определить, что книга принадлежит пользователю */
    let owned: Bool!
    /* Владелец книги */
    var ownerProfile: Profile!
    
    var length : CGFloat = 0
    
    init(output: BookViewPresenterProtocol, book: Book, owned: Bool){
        self.presenter = output
        self.book = book
        self.owned = owned
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Скролл вью содержащая все вьюшки
    let scrollView = UIScrollView()
    // Массив из пяти кнопок состояния
    var stars : [UIButton] = [UIButton]()
    // Коллекция картинок книги
    let imagesCorousel = UIScrollView()
    
    // Название книги
    let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21, weight: .regular)
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    // Автор книги
    let authorLabel :  UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    // Жанр книги
    let genreLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
        label.translatesAutoresizingMaskIntoConstraints = true
        
        return label
    }()
    
    // Описание книги
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    // Состояние
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
    
    // Картинка профиля владельца
    let profileImage : UIImageView = {
        let image = UIImage(named: "default")
        let imageView = UIImageView(image: image)
        imageView.frame.size = CGSize(width: 50, height: 50)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 25
        
        return imageView
    }()
    
    // Имя профиля владельца
    let userLabel :  UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    // Кнопка обмена
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
        
        // Задаем параметры вью и навигатора
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // Конфигурация presenter'а
        setPresenter()
        // Конфигурация вью
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.observeBookOwner(ownerId: book.ownerId!)
    }
    
    /* Устанавливаем делегат для обратной связи между пресентером и вью */
    func setPresenter(){
        presenter.setViewDelegate(delegate: self)
    }
    
    /* Задаем содержимое вью */
    func configureView(){
        scrollView.contentSize = CGSize(width: view.frame.width, height: 700)
        view.addSubview(scrollView)
        
        // картинки
        imagesCorousel.isPagingEnabled = true
        imagesCorousel.layer.cornerRadius = 15
        imagesCorousel.layer.masksToBounds = true
        
        if (book.bookImages.count == 0) {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 30, height: view.frame.width - 30))
            
            imageView.image = UIImage(named: "default")
            imageView.layer.cornerRadius = 15
            imageView.layer.masksToBounds = true
            
            imagesCorousel.addSubview(imageView)
        } else {
            for i in 0...book.bookImages.count - 1 {
                let offset = i == 0 ? 0 : (CGFloat(i) * view.bounds.width)
                
                let imageView = UIImageView(frame: CGRect(x: offset, y: 0, width: view.frame.width - 30, height: view.frame.width - 30))
                
                imageView.layer.cornerRadius = 15
                imageView.layer.masksToBounds = true
                imageView.contentMode = UIView.ContentMode.scaleAspectFill
                imageView.clipsToBounds = true
                imageView.contentMode = .scaleAspectFill
                
                imageView.image = UIImage(data: book.bookImages[i])
                
                imagesCorousel.addSubview(imageView)
            }
        }
        
        imagesCorousel.contentSize = CGSize(width: CGFloat(book.bookImages.count) * view.frame.width - 30, height: view.frame.width - 30)
        scrollView.addSubview(imagesCorousel)
        
        nameLabel.text = book.bookName
        scrollView.addSubview(nameLabel)
        
        authorLabel.text = book.bookAuthor
        scrollView.addSubview(authorLabel)
        
        
        genreLabel.text = book.bookGenres.name
        genreLabel.sizeToFit()
        genreLabel.textColor = .white
        genreLabel.backgroundColor = book.bookGenres.color
        length = self.genreLabel.frame.width
        scrollView.addSubview(genreLabel)
        
        descriptionLabel.text = book.bookDescription
        descriptionLabel.sizeToFit()
        scrollView.addSubview(descriptionLabel)
        
        scrollView.addSubview(conditionLabel)
        
        stars  = [conditionButton1, conditionButton2, conditionButton3, conditionButton4,  conditionButton5]
        
        for i in 0...book.bookCondition - 1{
            stars[i].setImage(UIImage(named: "conditionPaintedStarImage"), for: .normal)
        }
        
        for i in 0...4{
            print("ssss")
            scrollView.addSubview(stars[i])
        }
        
        if (!owned){
            scrollView.addSubview(profileImage)
            // book.owner
            userLabel.text = "Имя пользователя"
            scrollView.addSubview(userLabel)
            
            takeBookButton.addTarget(self,
                                     action: #selector(didTapTakeButton(_:)),
                                     for: .touchUpInside)
            view.addSubview(takeBookButton)
        }
    }
    
    @objc
    private func didTapTakeButton(_ sender: UIButton) {
        presenter.takeBookButtonAction(book: book)
    }
    
    func presentNextVC(){
        let presenterB = UserProfilePresenter()
        let vc = UserProfileViewController(output: presenterB, userId: book.ownerId!)
        
        self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
    }
    
    func loadBookOwner(ownerProfile: Profile) {
        self.ownerProfile = ownerProfile
        
        profileImage.image = ownerProfile.photo        //UIImage(named: "default")
        userLabel.text = ownerProfile.name
        
        updateLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func updateLayout(){
        scrollView.pin
            .topLeft()
            .height(view.frame.height)
            .width(view.frame.width)
        
        imagesCorousel.pin
            .top(15)
            .topCenter()
            .height(view.frame.width - 30)
            .width(view.frame.width - 30)
        
        nameLabel.pin
            .below(of: imagesCorousel)
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
            .width(length + 20)
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
            .width(28)
            .after(of: conditionLabel)
            .marginLeft(3)
            .below(of: descriptionLabel)
            .marginTop(5)
            .height(28)
        
        stars[1].pin
            .width(28)
            .after(of: stars[0])
            .marginLeft(1)
            .below(of: descriptionLabel)
            .marginTop(5)
            .height(28)
        
        stars[2].pin
            .width(28)
            .after(of: stars[1])
            .marginLeft(1)
            .below(of: descriptionLabel)
            .marginTop(5)
            .height(28)
        
        stars[3].pin
            .width(28)
            .after(of: stars[2])
            .marginLeft(1)
            .below(of: descriptionLabel)
            .marginTop(5)
            .height(28)
        
        stars[4].pin
            .width(28)
            .after(of: stars[3])
            .marginLeft(1)
            .below(of: descriptionLabel)
            .marginTop(5)
            .height(28)
        
        profileImage.pin
            .below(of: stars[4])
            .marginTop(10)
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
