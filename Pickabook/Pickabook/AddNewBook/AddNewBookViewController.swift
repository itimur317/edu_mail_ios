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
 
    let bookNameLabel = UILabel()
    let myButton = UIButton()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
 
        bookNameLabel.text = "Название"
        bookNameLabel.textAlignment = .center
        view.addSubview(bookNameLabel)
        myButton.setTitle("Ishodnoe", for: .normal)
        myButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        view.addSubview(myButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bookNameLabel.pin
            .top(100)
            .horizontally(10)
            .height(70)
        myButton.pin
            .center()
            .height(50)
            .width(50)
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
 
