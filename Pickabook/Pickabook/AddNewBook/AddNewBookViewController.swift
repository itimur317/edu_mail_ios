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
    
    let addPhotoLabel = UILabel()
    let photoLabel = UILabel()
    let addPhotoButton = UIButton()
    let addPhotoImage = UIImage(named: "addPhotoImage")
    
    let correctPhotoButton = UIButton()
    
    let bookNameLabel = UILabel()
    let bookNameTextView = UITextView()
    
    let authorNameLabel = UILabel()
    let authorNameTextView = UITextView()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.hideKeyboardWhenTappedAround()

        
        screenLabel.text = "Добавление книги"
        screenLabel.textAlignment = .center
        screenLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        view.addSubview(screenLabel)
        
        scrollView.backgroundColor = .green
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2200)
        view.addSubview(scrollView)

        
        
        addPhotoLabel.text = "Добавьте фото книги (максимум 3). \nДля комфортного обмена рекомендуем сделать фото обложки и титульного листа."
        addPhotoLabel.textAlignment = .left
        addPhotoLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        addPhotoLabel.numberOfLines = 0
        scrollView.addSubview(addPhotoLabel)
        
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
        correctPhotoButton.isHidden = true
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
        
        
        
        addPhotoLabel.pin
            .below(of: screenLabel).marginTop(10)
            .horizontally(12)
            .height(88)
        
        photoLabel.pin
            .below(of: addPhotoLabel).marginTop(10)
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
        if textView.text == "" || textView.textColor == .black {
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
 
 
 

 
 
 
