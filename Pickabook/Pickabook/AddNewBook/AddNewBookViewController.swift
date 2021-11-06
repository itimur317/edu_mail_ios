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
 
    let screenLabel = UILabel()
    let addPhotoButton = UIButton()
    let bookNameLabel = UILabel()
    let bookNameTextField = UITextField()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        screenLabel.text = "Добавление книги"
        screenLabel.textAlignment = .center
        screenLabel.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.semibold)
        view.addSubview(screenLabel)
        
        addPhotoButton.setTitle("Photos", for: .normal)
        addPhotoButton.backgroundColor = .red
        addPhotoButton.layer.cornerRadius = 8
        view.addSubview(addPhotoButton)
 
        bookNameLabel.text = "Название"
        bookNameLabel.textAlignment = .center
        view.addSubview(bookNameLabel)
        
       
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        screenLabel.pin
            .top(40)
            .horizontally(10)
            .height(70)
        
        bookNameLabel.pin
            .top(400)
            .horizontally(10)
            .height(70)
        //view.frame.width - ...
        addPhotoButton.pin
            .top(100)
            .left(12)
            .height((view.frame.width - 12 * 3) / 3)
            .width((view.frame.width - 12 * 3) / 3)
            .below(of: screenLabel).margin(10)
      
    }
 
    @objc
    func didTapAddButton(_ sender: Any){
        self.output.didTapAddButton()
    }
}
 
extension AddNewBookViewController: AddNewBookViewControllerProtocol{
    
}
 
 
 
 
 
 
 
 
 
 
 
/*
// тема позволяющая менять внутри viewcontr имя кнопки и тп
//
protocol PresenterOutputProtocol: AnyObject {
    func setNameBook(book: String)
}
 
// будет что то внутри презентера вертеться
// и потом вернется обратно во viewcontr
// она должна указать презентеру на то, что надо бы уметь обрабатывать нажатую
// кнопку в развернутом виде
 
 
protocol PresenterInputProtocol: AnyObject {
    init(output: PresenterOutputProtocol, book: Book)
    func didTapButton()
}
 
 
class AddBookViewController: UIViewController {
    var presenter: PresenterInputProtocol!
 
    @IBOutlet weak var addNameLabel: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
 
    @IBAction func didTapButton(_ sender: Any){
        self.presenter.didTapButton()
    }
}
 
// showGreeting у андрея он в презентере обработал простенько быстренько полное имя и затем сразу же его засетил во вью контроллер обратно
extension AddBookViewController: PresenterOutputProtocol {
    func setNameBook(book: String) {
        self.addNameLabel.text = book
    }
}
*/
 
