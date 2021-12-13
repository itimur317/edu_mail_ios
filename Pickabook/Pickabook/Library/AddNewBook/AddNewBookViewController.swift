//
//  AddBookViewController.swift
//  Pickabook
//
//  Created by Timur on 05.11.2021.
//

import UIKit
import Foundation
import PinLayout

protocol AddNewBookViewControllerProtocol: AnyObject {
    func changeCondition(_ addedCondition: Int)
    func failAddDoneView()
    func successAddDoneView()
    func requiredFieldAlert()
    func setDefault()
    func setImage(_ pickedImage: UIImage)
    func presentLoadingAlert()
    func dismissLoadingAlert()
    func openSavedPhotosAlbum()
}


final class AddNewBookViewController: UIViewController {
    var presenter: AddNewBookPresenterProtocol
    
    init(presenter: AddNewBookPresenterProtocol){
        self.presenter = presenter
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let scrollView = UIScrollView()
    let titleSize : CGFloat = 21
    
    let closeButtonImage = UIImage(named: "closeButton")
    
    let addPhotoDescriptionLabel = UILabel()
    let photoLabel = UILabel()
    let addPhotoButton = UIButton()
    let addPhotoImage = UIImage(named: "addPhotoImage")
    
    var addPhotoImagePicker = UIImagePickerController()
    let leftPhotoImageView = UIImageView()
    let centerPhotoImageView = UIImageView()
    let rightPhotoImageView = UIImageView()
    
    
    let leftNumberPhotoLabel = UILabel()
    let centerNumberPhotoLabel = UILabel()
    let rightNumberPhotoLabel = UILabel()
    
    
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
    let conditionStarImage = UIImage(named: "conditionStarImage")
    let conditionPaintedStarImage = UIImage(named: "conditionPaintedStarImage")
    
    let descriptionLabel = UILabel()
    let descriptionTextView = UITextView()
    
    let languageLabel = UILabel()
    let languageTextView = UITextView()
    
    let requiredLabel = UILabel()
    
    let addBookButton = UIButton()
    
    let genres = Util.shared.genres
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close,
                                          target: self,
                                          action: #selector(didTapCloseButton(_: )))
        
        navigationItem.rightBarButtonItem = closeButton
        
        addPhotoImagePicker.delegate = self
        
        view.backgroundColor = .white
        
        self.hideKeyboardWhenTappedAround()
        
        title = "Добавить книгу"
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1104)
        view.addSubview(scrollView)
        
        
        addPhotoDescriptionLabel.text = "Добавьте фото книги (максимум 3)."
        addPhotoDescriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        addPhotoDescriptionLabel.numberOfLines = 0
        scrollView.addSubview(addPhotoDescriptionLabel)
        
        photoLabel.text = "Фото*"
        photoLabel.textAlignment = .left
        photoLabel.font = UIFont.systemFont(ofSize: titleSize, weight: .medium)
        photoLabel.sizeToFit()
        scrollView.addSubview(photoLabel)
        
        addPhotoButton.backgroundColor = UIColor(named: "backgroundColorForEmpty")
        addPhotoButton.layer.cornerRadius = 8
        addPhotoButton.setImage(addPhotoImage, for: .normal)
        addPhotoButton.addTarget(self,
                                 action: #selector(didTapAddPhotoButton(_:)),
                                 for: .touchUpInside)
        scrollView.addSubview(addPhotoButton)
        
        let leftPhotoImageViewTapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                            action: #selector(didTapLeftPhotoImageView(tapGestureRecognizer:)))
        leftPhotoImageView.addGestureRecognizer(leftPhotoImageViewTapGestureRecognizer)
        
        let centerPhotoImageViewTapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                              action: #selector(didTapCenterPhotoImageView(tapGestureRecognizer:)))
        centerPhotoImageView.addGestureRecognizer(centerPhotoImageViewTapGestureRecognizer)
        
        let rightPhotoImageViewTapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                             action: #selector(didTapRightPhotoImageView(tapGestureRecognizer:)))
        rightPhotoImageView.addGestureRecognizer(rightPhotoImageViewTapGestureRecognizer)
        
        
        [leftPhotoImageView, centerPhotoImageView, rightPhotoImageView].forEach{
            $0.layer.cornerRadius = 8
            $0.layer.masksToBounds = true
            $0.isHidden = true
            $0.isUserInteractionEnabled = true
            scrollView.addSubview($0)
        }
        
        [leftNumberPhotoLabel, centerNumberPhotoLabel, rightNumberPhotoLabel].forEach {
            $0.text = "0"
            $0.backgroundColor = .black
            $0.font = UIFont.systemFont(ofSize: 10, weight: .bold)
            $0.textColor = .white
            $0.clipsToBounds = true
            $0.textAlignment = .center
            $0.layer.cornerRadius = 5
            $0.isHidden = true
            scrollView.addSubview($0)
        }
        
        correctPhotoButton.setTitle("Удалить фото", for: .normal)
        correctPhotoButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        correctPhotoButton.setTitleColor(.gray, for: .normal)
        correctPhotoButton.isHidden = true
        correctPhotoButton.addTarget(self,
                                     action: #selector(didTapCorrectPhotoButton(_:)),
                                     for: .touchUpInside)
        scrollView.addSubview(correctPhotoButton)
        
        
        bookNameLabel.text = "Название*"
        bookNameLabel.textAlignment = .left
        bookNameLabel.font = UIFont.systemFont(ofSize: titleSize, weight: .medium)
        bookNameLabel.sizeToFit()
        scrollView.addSubview(bookNameLabel)
        
        textViewDidBeginEditing(bookNameTextView)
        textViewDidEndEditing(bookNameTextView, "Укажите название книги(без кавычек)...")
        bookNameTextView.delegate = self
        bookNameTextView.layer.cornerRadius = 14
        bookNameTextView.font = UIFont.systemFont(ofSize: 16)
        bookNameTextView.textColor = .gray
        bookNameTextView.backgroundColor = .systemGray6
        scrollView.addSubview(bookNameTextView)
        
        authorNameLabel.text = "Автор*"
        authorNameLabel.textAlignment = .left
        authorNameLabel.font = UIFont.systemFont(ofSize: titleSize, weight: .medium)
        authorNameLabel.sizeToFit()
        scrollView.addSubview(authorNameLabel)
        
        textViewDidBeginEditing(authorNameTextView)
        textViewDidEndEditing(authorNameTextView, "Укажите автора книги...")
        authorNameTextView.delegate = self
        authorNameTextView.layer.cornerRadius = 14
        authorNameTextView.font = UIFont.systemFont(ofSize: 16)
        authorNameTextView.textColor = .gray
        authorNameTextView.backgroundColor = .systemGray6
        scrollView.addSubview(authorNameTextView)
        
        
        genresNameLabel.text = "Жанр*"
        genresNameLabel.textAlignment = .left
        genresNameLabel.font = UIFont.systemFont(ofSize: titleSize, weight: .medium)
        genresNameLabel.sizeToFit()
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
        conditionLabel.font = UIFont.systemFont(ofSize: titleSize, weight: .medium)
        conditionLabel.sizeToFit()
        scrollView.addSubview(conditionLabel)
        
        self.conditionButtons = [self.conditionFirstButton, self.conditionSecondButton, self.conditionThirdButton, self.conditionFourthButton, self.conditionFifthButton]
        
        for i in 0...4{
            conditionButtons[i].backgroundColor = .white
            conditionButtons[i].addTarget(self,
                                          action: #selector(didTapConditionButton(_:)),
                                          for: .touchUpInside)
            conditionButtons[i].setImage(conditionStarImage, for: .normal)
            scrollView.addSubview(conditionButtons[i])
        }
    
        
        descriptionLabel.text = "Описание"
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = UIFont.systemFont(ofSize: titleSize, weight: .medium)
        descriptionLabel.sizeToFit()
        scrollView.addSubview(descriptionLabel)
        
        textViewDidBeginEditing(descriptionTextView)
        textViewDidEndEditing(descriptionTextView, "Добавьте описание, например, наличие автографа автора или редкость издания...")
        descriptionTextView.delegate = self
        descriptionTextView.layer.cornerRadius = 14
        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
        descriptionTextView.textColor = .gray
        descriptionTextView.backgroundColor = .systemGray6
        scrollView.addSubview(descriptionTextView)
        
        languageLabel.text = "Язык*"
        languageLabel.textAlignment = .left
        languageLabel.font = UIFont.systemFont(ofSize: titleSize, weight: .medium)
        languageLabel.sizeToFit()
        scrollView.addSubview(languageLabel)
        
        languageTextView.text = "Русский"
        languageTextView.textAlignment = .left
        languageTextView.delegate = self
        languageTextView.layer.cornerRadius = 14
        languageTextView.font = UIFont.systemFont(ofSize: 16)
        languageTextView.textColor = .black
        languageTextView.backgroundColor = .systemGray6
        scrollView.addSubview(languageTextView)
        
        
        requiredLabel.text = "* - обозначены поля, обязательные для заполнения"
        requiredLabel.numberOfLines = 2
        requiredLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        scrollView.addSubview(requiredLabel)
        
        addBookButton.setTitle("Добавить", for: .normal)
        addBookButton.titleLabel?.textAlignment = .center
        addBookButton.setTitleColor(.white, for: .highlighted)
        addBookButton.backgroundColor = UIColor(named: "buttonColor")
        addBookButton.layer.cornerRadius = 15
        addBookButton.addTarget(self,
                                action: #selector(didTapAddButton(_:)),
                                for: .touchUpInside)
        scrollView.addSubview(addBookButton)
        
    }
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.pin
            .top(view.pin.safeArea)
            .bottom(view.pin.safeArea)
            .width(view.frame.width)
        
        addPhotoDescriptionLabel.pin
            .top(12)
            .horizontally(12)
            .height(23)
        
        photoLabel.pin
            .below(of: addPhotoDescriptionLabel).marginTop(10)
            .left(12)
            .height(23)
        
        addPhotoButton.pin
            .below(of: photoLabel).marginVertical(12)
            .left(12)
            .height((view.frame.width - 12 * 4) / 3)
            .width((view.frame.width - 12 * 4) / 3)
        
        
        rightPhotoImageView.pin
            .below(of: photoLabel).marginVertical(12)
            .left(12 * 3 + 2 * addPhotoButton.frame.width)
            .right(12)
            .height(addPhotoButton.frame.height)
            .width(addPhotoButton.frame.width)
        
        rightNumberPhotoLabel.pin
            .below(of: photoLabel).marginVertical(20)
            .left(12 * 3 + 3 * rightPhotoImageView.frame.width - 14 - 6)
            .height(14)
            .width(14)
        
        centerPhotoImageView.pin
            .below(of: photoLabel).marginVertical(12)
            .left(12 * 2 + addPhotoButton.frame.width)
            .height(addPhotoButton.frame.height)
            .width(addPhotoButton.frame.width)
        
        centerNumberPhotoLabel.pin
            .below(of: photoLabel).marginVertical(20)
            .left(12 * 2 + 2 * centerPhotoImageView.frame.width - 14 - 6)
            .height(14)
            .width(14)
        
        leftPhotoImageView.pin
            .below(of: photoLabel).marginVertical(12)
            .left(12)
            .height(addPhotoButton.frame.height)
            .width(addPhotoButton.frame.width)
        
        leftNumberPhotoLabel.pin
            .below(of: photoLabel).marginVertical(20)
            .left(12 + leftPhotoImageView.frame.width - 14 - 6)
            .height(14)
            .width(14)
        
        
        correctPhotoButton.pin
            .below(of: addPhotoButton).marginTop(10)
            .left(view.frame.width / 2 - 52)
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
                .after(of: conditionLabel).marginLeft(12 + CGFloat(i) *  conditionButtons[0].frame.width)
                .below(of: genresToChoosePickerView).marginTop(8)
                .height(32)
        }
        
        
        descriptionLabel.pin
            .below(of: conditionLabel).marginTop(12)
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
        
        requiredLabel.pin
            .below(of: languageTextView).marginTop(12)
            .horizontally(12)
            .height(50)
        
        
        addBookButton.pin
            .below(of: requiredLabel).marginTop(12)
            .left(view.frame.width / 2 - 100)
            .width(200)
            .height(50)
    }
}


// for @objc func
extension AddNewBookViewController {
    
    @objc
    private func didTapLeftPhotoImageView(tapGestureRecognizer: UITapGestureRecognizer) {
        print("left")
        if let image = leftPhotoImageView.image {
            openAddNewBookAddedPhotoView(image)
        }
    }
    
    
    @objc
    private func didTapCenterPhotoImageView(tapGestureRecognizer: UITapGestureRecognizer) {
        print("center")
        if let image = centerPhotoImageView.image {
            openAddNewBookAddedPhotoView(image)
        }
    }
    
    
    @objc
    private func didTapRightPhotoImageView(tapGestureRecognizer: UITapGestureRecognizer) {

        if let image = rightPhotoImageView.image {
            openAddNewBookAddedPhotoView(image)
        }
    }
    
    
    @objc
    private func didTapCloseButton(_ sender: UIBarButtonItem) {
        
        if !self.isDefault() {
            let alert = UIAlertController(title: "Выйти?", message: "Данные не сохранятся.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Да", style: .destructive)
                            {_ in self.dismiss(animated: true, completion: nil)})
            
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            
            present(alert, animated: true)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @objc
    private func didTapAddButton(_ sender: UIButton) {
        
        // MARK : change from 0.1 to 1.0 or smth
        let leftPhotoImageViewData = leftPhotoImageView.image?.jpegData(compressionQuality: 0.1)
        let centerPhotoImageViewData = centerPhotoImageView.image?.jpegData(compressionQuality: 0.1)
        let rightPhotoImageViewData = rightPhotoImageView.image?.jpegData(compressionQuality: 0.1)
        
        
        self.presenter.didTapAddButton(bookImages: [leftPhotoImageViewData, centerPhotoImageViewData, rightPhotoImageViewData],
                                    bookName: bookNameTextView.text.trimmingCharacters(in: .whitespacesAndNewlines),
                                    bookNameColor: bookNameTextView.textColor!,
                                    authorName: authorNameTextView.text.trimmingCharacters(in: .whitespacesAndNewlines),
                                    authorNameColor : authorNameTextView.textColor!,
                                    bookDescription: descriptionTextView.text.trimmingCharacters(in: .whitespacesAndNewlines),
                                    bookDescriptionColor : descriptionTextView.textColor!,
                                    bookLanguage: languageTextView.text.trimmingCharacters(in: .whitespacesAndNewlines),
                                    bookLanguageColor: languageTextView.textColor!)
        
    }
    
    
    @objc
    private func didTapConditionButton(_ sender: UIButton) {
        
        var addedCondition: Int = 0
        
        for i in 0...4 {
            conditionButtons[i].setImage(conditionStarImage, for: .normal)
        }
        
        for i in 0...4 {
            if sender == conditionButtons[i] {
                addedCondition = i + 1
                break
            }
        }
        
        self.presenter.didTapConditionButton(addedCondition)
        
    }
    
    
    @objc
    private func didTapAddPhotoButton(_ sender: UIButton) {
        
        self.presenter.didTapAddPhotoButton()
    }
    
    
    @objc
    private func didTapCorrectPhotoButton(_ sender: UIButton) {
        
        if leftPhotoImageView.image != nil {
            addPhotoButton.isHidden = false
        }
        
        [leftPhotoImageView, centerPhotoImageView, rightPhotoImageView].forEach {
            if $0.image != nil {
                $0.image = nil
                $0.isHidden = true
            }
        }
        
        [leftNumberPhotoLabel, centerNumberPhotoLabel, rightNumberPhotoLabel].forEach {
            if $0.text != "0" {
                $0.text = "0"
                $0.isHidden = true
            }
        }
        
        correctPhotoButton.isHidden = true
    }
    
}

// for placeholder in UITextView
extension AddNewBookViewController: UITextViewDelegate {
    
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
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(AddNewBookViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}


// for genre picker
extension AddNewBookViewController:UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres[row].name
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            //requiredFieldAlert()
            presenter.newBook.bookGenres.type = .notSelected
        }
        else {
            presenter.newBook.bookGenres = genres[row]
        }
    }
}


extension AddNewBookViewController: AddNewBookViewControllerProtocol {
    
    func failAddDoneView() {
        let failAddNewBookPresenter = FailAddNewBookPresenter(book: self.presenter.newBook)
        let failAddNewBookViewController = FailAddNewBookViewController(presenter: failAddNewBookPresenter)
        failAddNewBookPresenter.view = failAddNewBookViewController
        failAddNewBookViewController.modalPresentationStyle = .fullScreen
        present(failAddNewBookViewController,
                animated: true,
                completion: nil)
        
        
    }
    
    func successAddDoneView() {
        
        let successAddNewBookPresenter = SuccessAddNewBookPresenter()
        let successAddNewBookViewController = SuccessAddNewBookViewController(presenter: successAddNewBookPresenter)
        successAddNewBookPresenter.view = successAddNewBookViewController
        successAddNewBookViewController.modalPresentationStyle = .fullScreen
        present(successAddNewBookViewController,
                animated: true,
                completion: nil)
        
    }
    
    
    func requiredFieldAlert() {
        let alert = UIAlertController(title: "Недостаточно данных",
                                      message: "Заполните обязательные поля!",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ок",
                                      style: .default,
                                      handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
    func changeCondition(_ addedCondition: Int) {
        for i in 0 ..< addedCondition {
            conditionButtons[i].setImage(conditionPaintedStarImage,
                                         for: .normal)
        }
    }
    
    
    func setDefault() {
        bookNameTextView.textColor = .gray
        bookNameTextView.text = "Укажите название книги(без кавычек)..."
        
        authorNameTextView.textColor = .gray
        authorNameTextView.text = "Укажите автора книги..."
        
        for i in 0..<5 {
            conditionButtons[i].setImage(conditionStarImage, for: .normal)
        }
        
        self.genresToChoosePickerView.selectRow(0, inComponent: 0, animated: true)
        
        descriptionTextView.textColor = .gray
        descriptionTextView.text = "Добавьте описание, например, наличие автографа автора или редкость издания..."
        
        languageTextView.text = "Русский"
        
    }
    
    
    func isDefault() -> Bool {
        if  correctPhotoButton.isHidden &&
            bookNameTextView.textColor == .gray &&
            bookNameTextView.text == "Укажите название книги(без кавычек)..." &&
            authorNameTextView.textColor == .gray &&
            authorNameTextView.text == "Укажите автора книги..." &&
            conditionButtons[0].currentImage == UIImage(named: "conditionStarImage") &&
            genresToChoosePickerView.selectedRow(inComponent: 0) == 0 &&
            descriptionTextView.textColor == .gray &&
            descriptionTextView.text == "Добавьте описание, например, наличие автографа автора или редкость издания..."
            && languageTextView.text == "Русский" {
            return true
        }
        
        return false

    }
    
    
    func setImage(_ pickedImage: UIImage) {
        if centerPhotoImageView.image == nil {
            
            centerNumberPhotoLabel.isHidden = false
            centerNumberPhotoLabel.text = "1"
            
            centerPhotoImageView.isHidden = false
            centerPhotoImageView.contentMode = .scaleToFill
            centerPhotoImageView.image = pickedImage
            
        }
        else if rightPhotoImageView.image == nil {
            
            rightNumberPhotoLabel.isHidden = false
            
            rightNumberPhotoLabel.text = "1"
            centerNumberPhotoLabel.text = "2"
            
            rightPhotoImageView.isHidden = false
            rightPhotoImageView.contentMode = .scaleToFill
            rightPhotoImageView.image = centerPhotoImageView.image
            
            centerPhotoImageView.image = pickedImage
            
        }
        else {
            
            leftNumberPhotoLabel.isHidden = false
            leftNumberPhotoLabel.text = "3"
            
            leftPhotoImageView.isHidden = false
            leftPhotoImageView.contentMode = .scaleToFill
            leftPhotoImageView.image = pickedImage
            
            addPhotoButton.isHidden = true
            
        }
        
        correctPhotoButton.isHidden = false
    }
    
    
    private func openAddNewBookAddedPhotoView(_ image : UIImage) {
        let addNewBookAddPhotoView = AddNewBookAddPhotoView(image)
        addNewBookAddPhotoView.modalPresentationStyle = .overFullScreen
        present(addNewBookAddPhotoView,
                animated: true,
                completion: nil)
    }
    
    func presentLoadingAlert() {
        let alert = UIAlertController(title: nil, message: "Загружаем книгу...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func dismissLoadingAlert() {
        dismiss(animated: true, completion: nil)
    }
    
    func openSavedPhotosAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            addPhotoImagePicker.allowsEditing = false
            addPhotoImagePicker.sourceType = .savedPhotosAlbum
            
            present(addPhotoImagePicker,
                    animated: true,
                    completion: nil)
        } else {
            let alert = UIAlertController(title: "Нет доступа!",
                                          message: "У Pickabook нет доступа к вашим фото.\nЧтобы предоставить доступ, перейдите в Настройки и включите Фото.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ок",
                                          style: .default,
                                          handler: nil))
            
            present(alert, animated: true)
        }
    }
}

extension AddNewBookViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            setImage(pickedImage)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

