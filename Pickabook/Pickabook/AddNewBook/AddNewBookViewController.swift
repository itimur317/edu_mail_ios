//
//  AddBookViewController.swift
//  Pickabook
//
//  Created by Timur on 05.11.2021.
//
 
import UIKit
import PinLayout

 
class AddNewBookViewController: UIViewController {
    var newBook: Book?
    var output: AddNewBookPresenterProtocol
    
    init(output: AddNewBookPresenterProtocol){
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let scrollView = UIScrollView()

    let screenLabel = UILabel()
    
    let addPhotoDescriptionLabel = UILabel()
    let photoLabel = UILabel()
    let addPhotoButton = UIButton()
    let addPhotoImage = UIImage(named: "addPhotoImage")
    //dodelat' photo
    let firstAddedPhotoImage = UIImage()
    let secondAddedPhotoImage = UIImage()
    let thirdAddedPhotoImage = UIImage()
    
    let correctPhotoButton = UIButton()
    
    let bookNameLabel = UILabel()
    let bookNameTextView = UITextView()
    
    let authorNameLabel = UILabel()
    let authorNameTextView = UITextView()
    
    let genresNameLabel = UILabel()
    let addGenresDescriptionLabel = UILabel()
    let selectedGenreLabel = UILabel()
    let selectedGenreFromDictLabel = UILabel()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.hideKeyboardWhenTappedAround()

        
        screenLabel.text = "Добавление книги"
        screenLabel.textAlignment = .center
        screenLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        view.addSubview(screenLabel)
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2200)
        view.addSubview(scrollView)


        addPhotoDescriptionLabel.text = "Добавьте фото книги (максимум 3). \nДля комфортного обмена рекомендуем сделать фото обложки и титульного листа."
        addPhotoDescriptionLabel.textAlignment = .left
        addPhotoDescriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        addPhotoDescriptionLabel.numberOfLines = 0
        scrollView.addSubview(addPhotoDescriptionLabel)
        
        photoLabel.text = "Фото"
        photoLabel.textAlignment = .left
        photoLabel.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        scrollView.addSubview(photoLabel)
        
        addPhotoButton.backgroundColor = .blue
        addPhotoButton.layer.cornerRadius = 8
        addPhotoButton.setImage(addPhotoImage, for: .normal)
        scrollView.addSubview(addPhotoButton)
        
        
        correctPhotoButton.setTitle("Изменить фото", for: .normal)
        correctPhotoButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        correctPhotoButton.setTitleColor(.gray, for: .normal)
        // hide it
      //  correctPhotoButton.isHidden = true
        scrollView.addSubview(correctPhotoButton)
        
 
        bookNameLabel.text = "Название"
        bookNameLabel.textAlignment = .left
        bookNameLabel.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        scrollView.addSubview(bookNameLabel)
        
        textViewDidBeginEditing(bookNameTextView)
        textViewDidEndEditing(bookNameTextView, "Укажите название книги(без кавычек)...")
        bookNameTextView.delegate = self
        bookNameTextView.layer.cornerRadius = 2
        bookNameTextView.font = UIFont.systemFont(ofSize: 16)
        bookNameTextView.textColor = .gray
        bookNameTextView.backgroundColor = .systemGray3
        scrollView.addSubview(bookNameTextView)
        
        
        authorNameLabel.text = "Автор"
        authorNameLabel.textAlignment = .left
        authorNameLabel.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        scrollView.addSubview(authorNameLabel)
        
        textViewDidBeginEditing(authorNameTextView)
        textViewDidEndEditing(authorNameTextView, "Укажите автора книги...")
        authorNameTextView.delegate = self
        authorNameTextView.layer.cornerRadius = 2
        authorNameTextView.font = UIFont.systemFont(ofSize: 16)
        authorNameTextView.textColor = .gray
        authorNameTextView.backgroundColor = .systemGray3
        scrollView.addSubview(authorNameTextView)
        
        genresNameLabel.text = "Жанр"
        genresNameLabel.textAlignment = .left
        genresNameLabel.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        scrollView.addSubview(genresNameLabel)
        
        addGenresDescriptionLabel.text = "Выберите из перечисленных жанр, который лучше всего описывают книгу - другим читателям будет проще найти ее."
        addGenresDescriptionLabel.textAlignment = .left
        addGenresDescriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        addGenresDescriptionLabel.numberOfLines = 0
        scrollView.addSubview(addGenresDescriptionLabel)
        
        selectedGenreLabel.text = "Выбран:"
        selectedGenreLabel.textAlignment = .left
        selectedGenreLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        scrollView.addSubview(selectedGenreLabel)
        
        // add size and color from button
        selectedGenreFromDictLabel.textAlignment = .center
        scrollView.addSubview(selectedGenreFromDictLabel)
        
    }
    
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        screenLabel.pin
            .top(50)
            .horizontally(12)
            .height(28)
        
        
        scrollView.pin
            .below(of: screenLabel).marginTop(0)
            .top(390)
            .height(view.frame.height)
            .width(view.frame.width)
        
        
        
        addPhotoDescriptionLabel.pin
            .below(of: screenLabel).marginTop(10)
            .horizontally(12)
            .height(88)
        
        photoLabel.pin
            .below(of: addPhotoDescriptionLabel).marginTop(10)
            .horizontally(12)
            .height(23)
        
        addPhotoButton.pin
            .below(of: photoLabel).marginVertical(12)
            .left(12)
            .height((view.frame.width - 12 * 3) / 3)
            .width((view.frame.width - 12 * 3) / 3)
        
        
        correctPhotoButton.pin
            .below(of: addPhotoButton).marginTop(10)
            .center()
            .height(17)
            .width(104)
        
        
        bookNameLabel.pin
            .below(of: addPhotoButton).marginTop(30)
            .horizontally(12)
            .height(23)
        
        bookNameTextView.pin
            .below(of: bookNameLabel).marginTop(12)
            .horizontally(12)
            .height(74)
        
        
        authorNameLabel.pin
            .below(of: bookNameTextView).marginTop(12)
            .horizontally(12)
            .height(23)
        
        authorNameTextView.pin
            .below(of: authorNameLabel).marginTop(12)
            .horizontally(12)
            .height(74)
        
        
        genresNameLabel.pin
            .below(of: authorNameTextView).marginTop(12)
            .horizontally(12)
            .height(23)
        
        addGenresDescriptionLabel.pin
            .below(of: genresNameLabel).marginTop(10)
            .horizontally(12)
            .height(66)
        
        selectedGenreLabel.pin
            .below(of: addGenresDescriptionLabel).marginTop(10)
            .left(12)
            .width(80)
            .height(25)
        
        selectedGenreFromDictLabel.pin
            .below(of: selectedGenreLabel).marginLeft(10)
            .below(of: addGenresDescriptionLabel).marginTop(10)
            //dodelat posle knopok
    }
    

    @objc
    func didTapAddButton(_ sender: Any){
        self.output.didTapAddButton()
    }

    
}


// for placeholder in UITextView
extension AddNewBookViewController:UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray {
            textView.text = ""
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView, _ placeholder: String) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = .gray
        }
    }
     
}
 

extension AddNewBookViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddNewBookViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension AddNewBookViewController: AddNewBookViewControllerProtocol {
    
}
 
 
 

 
 
 
