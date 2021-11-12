//
//  AddBookViewController.swift
//  Pickabook
//
//  Created by Timur on 05.11.2021.
//
 
import UIKit
import Foundation
import PinLayout

 
public class SimpleLine: UIView  {
    var line = UIBezierPath()
    
    func graph() {
        line.move(to: .init(x: 0, y: bounds.height / 2))
        line.addLine(to: .init(x: bounds.width, y: bounds.height))
        UIColor(red: 0.49, green: 0.49, blue: 0.49, alpha: 1.00).setStroke()
        line.lineWidth = 1
        line.stroke()
    }
    
    override public func draw(_ rect: CGRect) {
        graph()
    }
}

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
    
    let screenLabel = UILabel()
    
    let scrollView = UIScrollView()
    
    let line = SimpleLine(frame: CGRect(x: 0, y: 0, width: 200, height: 2))
    
    let menuBackgroundLabel = UILabel()
    let menuRecommendButton = UIButton()
    let menuRecommendImage = UIImage(named: "Recommend")
    let menuFavouriteButton = UIButton()
    let menuFavouriteImage = UIImage(named: "Favourite")
    let menuAddBookButton = UIButton()
    let menuAddBookImage = UIImage(named: "AddBookActive")
    let menuProfileButton = UIButton()
    let menuProfileImage = UIImage(named: "Profile")
    
    let addPhotoDescriptionLabel = UILabel()
    let photoLabel = UILabel()
    let addPhotoButton = UIButton()
    let addPhotoImage = UIImage(named: "addPhotoImage")
    //dodelat' photo
    let firstAddedPhotoImageView = UIImageView()
    let secondAddedPhotoImageView = UIImageView()
    let thirdAddedPhotoImageView = UIImageView()
    
    let correctPhotoButton = UIButton()
    
    let bookNameLabel = UILabel()
    let bookNameTextView = UITextView()
    
    let authorNameLabel = UILabel()
    let authorNameTextView = UITextView()
    
    let genresNameLabel = UILabel()
    let addGenresDescriptionLabel = UILabel()
    let genresToChoosePickerView = UIPickerView()
    
    let conditionLabel = UILabel()
    let conditionFirstButton = UIButton()
    let conditionSecondButton = UIButton()
    let conditionThirdButton = UIButton()
    let conditionFourthButton = UIButton()
    let conditionFifthButton = UIButton()
    var conditionButtons: [UIButton] = [UIButton]()
    let conditionStarImage = UIImage(named: "star")
    let conditionPaintedStarImage = UIImage(named: "paintedStar")
    let conditionDescriptionLabel = UILabel()
    
    let descriptionLabel = UILabel()
    let descriptionTextView = UITextView()
    
    let languageLabel = UILabel()
    let languageTextView = UITextView()
    
    let addBookButton = UIButton()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        self.hideKeyboardWhenTappedAround()
        
        screenLabel.text = "Добавление книги"
        screenLabel.textAlignment = .center
        screenLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        view.addSubview(screenLabel)
        
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1660)
        view.addSubview(scrollView)
        
        menuBackgroundLabel.backgroundColor = UIColor(red: 0.97, green: 0.98, blue: 0.98, alpha: 1.00)
        view.addSubview(menuBackgroundLabel)
        
        menuRecommendButton.backgroundColor = UIColor(red: 0.97, green: 0.98, blue: 0.98, alpha: 1.00)
        menuRecommendButton.setImage(menuRecommendImage, for: .normal)
        view.addSubview(menuRecommendButton)
        
        menuFavouriteButton.backgroundColor = UIColor(red: 0.97, green: 0.98, blue: 0.98, alpha: 1.00)
        menuFavouriteButton.setImage(menuFavouriteImage, for: .normal)
        view.addSubview(menuFavouriteButton)
        
        menuAddBookButton.backgroundColor = UIColor(red: 0.97, green: 0.98, blue: 0.98, alpha: 1.00)
        menuAddBookButton.setImage(menuAddBookImage, for: .normal)
        view.addSubview(menuAddBookButton)
        
        menuProfileButton.backgroundColor = UIColor(red: 0.97, green: 0.98, blue: 0.98, alpha: 1.00)
        menuProfileButton.setImage(menuProfileImage, for: .normal)
        view.addSubview(menuProfileButton)
        
        
        line.backgroundColor = .white
        view.addSubview(line)
        
        
        addPhotoDescriptionLabel.text = "Добавьте фото книги (максимум 3). \nДля комфортного обмена рекомендуем сделать фото обложки и титульного листа."
        addPhotoDescriptionLabel.textAlignment = .left
        addPhotoDescriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        addPhotoDescriptionLabel.numberOfLines = 0
        scrollView.addSubview(addPhotoDescriptionLabel)
        
        photoLabel.text = "Фото*"
        photoLabel.textAlignment = .left
        photoLabel.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        scrollView.addSubview(photoLabel)
        
        addPhotoButton.backgroundColor = .blue
        addPhotoButton.layer.cornerRadius = 8
        addPhotoButton.setImage(addPhotoImage, for: .normal)
        scrollView.addSubview(addPhotoButton)
        
        firstAddedPhotoImageView.layer.cornerRadius = 8
       // firstAddedPhotoImage.image = фото из библ
        firstAddedPhotoImageView.isHidden = true
        scrollView.addSubview(firstAddedPhotoImageView)
        
        secondAddedPhotoImageView.layer.cornerRadius = 8
       // firstAddedPhotoImage.image = фото из библ
        firstAddedPhotoImageView.isHidden = true
        scrollView.addSubview(secondAddedPhotoImageView)
        
        thirdAddedPhotoImageView.layer.cornerRadius = 8
       // firstAddedPhotoImage.image = фото из библ
        firstAddedPhotoImageView.isHidden = true
        scrollView.addSubview(thirdAddedPhotoImageView)
        
        correctPhotoButton.setTitle("Удалить фото", for: .normal)
        correctPhotoButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        correctPhotoButton.setTitleColor(.gray, for: .normal)
        // hide it
        correctPhotoButton.isHidden = true
        scrollView.addSubview(correctPhotoButton)
        
 
        bookNameLabel.text = "Название*"
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
        
        
        authorNameLabel.text = "Автор*"
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
        
        genresNameLabel.text = "Жанр*"
        genresNameLabel.textAlignment = .left
        genresNameLabel.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        scrollView.addSubview(genresNameLabel)
        
        addGenresDescriptionLabel.text = "Выберите из списка ниже жанр, который лучше всего описывают книгу - другим читателям будет проще найти ее."
        addGenresDescriptionLabel.textAlignment = .left
        addGenresDescriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        addGenresDescriptionLabel.numberOfLines = 0
        scrollView.addSubview(addGenresDescriptionLabel)

        genresToChoosePickerView.delegate = self
        genresToChoosePickerView.dataSource = self
        scrollView.addSubview(genresToChoosePickerView)
        
        
        conditionLabel.text = "Состояние*"
        conditionLabel.textAlignment = .left
        conditionLabel.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        scrollView.addSubview(conditionLabel)
        
        self.conditionButtons = [self.conditionFirstButton, self.conditionSecondButton, self.conditionThirdButton, self.conditionFourthButton, self.conditionFifthButton]
        
        for i in 0...4{
            conditionButtons[i].backgroundColor = .white
            conditionButtons[i].setImage(conditionStarImage, for: .normal)
            scrollView.addSubview(conditionButtons[i])
        }
        
        conditionDescriptionLabel.text = "5 звезд \nКнига находится в идеальном состоянии\n\n4 звезды \nКнига была прочитана пару раз, использовалась аккуратно - нет заметных повреждений\n\n3 звезды\nКнига была прочитана несколько раз, допустимы небольшие повреждения(царапины на обложке, погнутые страницы и тп)\n\n2 звезды\nКнига была прочитана много раз, имеются повреждения(порванные или разрисованные страницы)\n\n1 звезда\nКнига находится в плохом состоянии, повреждения могут препятствовать чтению"
        conditionDescriptionLabel.textAlignment = .left
        conditionDescriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        conditionDescriptionLabel.numberOfLines = 0
        scrollView.addSubview(conditionDescriptionLabel)
        
        
        descriptionLabel.text = "Описание"
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        scrollView.addSubview(descriptionLabel)
        
        textViewDidBeginEditing(descriptionTextView)
        textViewDidEndEditing(descriptionTextView, "Добавьте описание, например, наличие автографа автора или редкость издания...")
        descriptionTextView.delegate = self
        descriptionTextView.layer.cornerRadius = 2
        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
        descriptionTextView.textColor = .gray
        descriptionTextView.backgroundColor = .systemGray3
        scrollView.addSubview(descriptionTextView)
        
        languageLabel.text = "Язык*"
        languageLabel.textAlignment = .left
        languageLabel.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        scrollView.addSubview(languageLabel)
        
        languageTextView.text = "Русский"
        languageTextView.textAlignment = .left
        languageTextView.delegate = self
        languageTextView.layer.cornerRadius = 2
        languageTextView.font = UIFont.systemFont(ofSize: 16)
        languageTextView.textColor = .black
        languageTextView.backgroundColor = .systemGray3
        scrollView.addSubview(languageTextView)
        
        addBookButton.setTitle("Добавить", for: .normal)
        addBookButton.titleLabel?.textAlignment = .center
        addBookButton.setTitleColor(.white, for: .highlighted)
        addBookButton.backgroundColor = UIColor(red: 0.99, green: 0.53, blue: 0.16, alpha: 1.00)
        addBookButton.layer.cornerRadius = 10
        scrollView.addSubview(addBookButton)

    }
    
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        screenLabel.pin
            .top(50)
            .horizontally(12)
            .height(28)
        
        line.pin
            .width(view.frame.width)
            .bottom(80)
        
        menuBackgroundLabel.pin
            .height(80)
            .width(view.frame.width)
            .bottom(0)
        
        menuRecommendButton.pin
            .width((view.frame.width - 14 * 5) / 4)
            .height(60)
            .bottom(20)
            .left(14)
        
        menuFavouriteButton.pin
            .width((view.frame.width - 14 * 5) / 4)
            .height(60)
            .bottom(20)
            .left(14 * 2 + menuRecommendButton.frame.width)
        
        menuAddBookButton.pin
            .width((view.frame.width - 14 * 5) / 4)
            .height(60)
            .bottom(20)
            .left(14 * 3 + 2 * menuRecommendButton.frame.width)
        
        menuProfileButton.pin
            .width((view.frame.width - 14 * 5) / 4)
            .height(60)
            .bottom(20)
            .left(14 * 4 + 3 * menuRecommendButton.frame.width)
            .right(14)
        
        
        scrollView.pin
            .below(of: screenLabel).marginTop(10)
            .height(view.frame.height - (50 + screenLabel.frame.height) - (20 + menuRecommendButton.frame.height) - 1)
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
            .height((view.frame.width - 12 * 4) / 3)
            .width((view.frame.width - 12 * 4) / 3)
        
        firstAddedPhotoImageView.pin
            .below(of: photoLabel).marginVertical(12)
            .left(12 * 3 + 2 * addPhotoButton.frame.width)
            .right(12)
            .height(addPhotoButton.frame.height)
            .width(addPhotoButton.frame.width)
        
        secondAddedPhotoImageView.pin
            .below(of: photoLabel).marginVertical(12)
            .left(12 * 2 + addPhotoButton.frame.width)
            .height(addPhotoButton.frame.height)
            .width(addPhotoButton.frame.width)
        
        thirdAddedPhotoImageView.pin
            .below(of: photoLabel).marginVertical(12)
            .left(12)
            .height(addPhotoButton.frame.height)
            .width(addPhotoButton.frame.width)
        
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
        
        genresToChoosePickerView.pin
            .below(of: addGenresDescriptionLabel).marginTop(12)
            .horizontally(12)
            .height(120)
        
        conditionLabel.pin
            .below(of: genresToChoosePickerView).marginTop(12)
            .left(12)
            .width(135)
            .height(23)
        
        for i in 0...4 {
            conditionButtons[i].pin
                .width(32)
                .after(of: conditionLabel).marginLeft(30 + CGFloat(i) *  conditionButtons[0].frame.width)
                .below(of: genresToChoosePickerView).marginTop(8)
                .height(32)
        }
        
        conditionDescriptionLabel.pin
            .below(of: conditionButtons[0]).marginTop(12)
            .horizontally(12)
            .height(500)
        
        
        descriptionLabel.pin
            .below(of: conditionDescriptionLabel).marginTop(12)
            .horizontally(12)
            .height(23)
        
        descriptionTextView.pin
            .below(of: descriptionLabel).marginTop(12)
            .horizontally(12)
            .height(115)
        
        
        languageLabel.pin
            .below(of: descriptionTextView).marginTop(12)
            .horizontally(12)
            .height(23)
        
        languageTextView.pin
            .below(of: languageLabel).marginTop(12)
            .horizontally(12)
            .height(34)
        
        
        addBookButton.pin
            .below(of: languageTextView).marginTop(40)
            .center()
            .width(130)
            .height(40)

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
 

// to hide keyboard when tap
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

// for genre picker
extension AddNewBookViewController:UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayOfGenres.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayOfGenres[row].genre
    }
    
}


extension AddNewBookViewController: AddNewBookViewControllerProtocol {
    
    func saveTextViewContents(){
        newBook?.bookName = bookNameTextView.text!
        newBook?.bookAuthor = authorNameTextView.text!

        // picker number id
        newBook?.bookGenreId = 3
        
        // вставить номер кнопки
        newBook?.bookCondition = 3
        
        if descriptionTextView.text.isEmpty {
            newBook?.bookDescription = nil
        }
        else {
            newBook?.bookDescription = descriptionTextView.text
        }
        
        newBook?.bookLanguage = languageTextView.text
    }
    
}
 


 
 

 
 
 
