//
//  LibraryViewController.swift
//  Pickabook
//
//  Created by Timur on 19.11.2021.
//

import Foundation
import UIKit
import PinLayout

protocol LibraryViewControllerProtocol : AnyObject {
    func dismissView()
    func didTapOpenBook(book: Book)
    func didTapOpenAddNewBook()
    func reloadTable()
}

final class LibraryViewController : UIViewController {
    
    var presenter: LibraryPresenterProtocol
    
    init(presenter: LibraryPresenterProtocol){
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let addNewBookButton = UIButton()
    let booksTableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        self.presenter.observeBooks()

        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.tintColor = .black
        
        self.navigationController?.navigationBar.topItem?.title = "Книги на обмен"
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "search"), style: .plain, target: self, action: #selector(didTapEditBarButton(_: )))
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "search"), style: .plain, target: self, action: #selector(didTapEditBarButton(_: )))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(didTapEditBarButton(_ :)))
        
        
        booksTableView.dataSource = self
        booksTableView.delegate = self
        booksTableView.register(BookTableCell.self, forCellReuseIdentifier: "BookTableCell")
        booksTableView.separatorStyle = .none
//        booksTableView.allowsSelection = false
        view.addSubview(booksTableView)
        
        addNewBookButton.setTitle("Добавить книгу",
                                  for: .normal)
        addNewBookButton.setTitleColor(.white, for: .normal)
        addNewBookButton.layer.cornerRadius = 20
        addNewBookButton.addTarget(self,
                                   action: #selector(didTapAddNewBookButton(_:)),
                                   for: .touchUpInside)
        addNewBookButton.backgroundColor = UIColor(named: "buttonColor")
        view.addSubview(addNewBookButton)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
//        self.presenter.observeBooks()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        booksTableView.pin
            .top(view.pin.safeArea).marginTop(12)
            .horizontally(12)
            .bottom(view.pin.safeArea)
        
        addNewBookButton.pin
            .bottom(view.pin.safeArea).marginBottom(12)
            .left(view.frame.width / 2 - 100)
            .width(200)
            .height(50)
    }
    
    @objc
    private func didTapAddNewBookButton(_ sender: UIButton) {
        presenter.didTapOpenAddNewBook()
    }
    
    
    @objc
    private func didTapEditBarButton(_ sender: UIButton) {
        print("editing")
    }
    
    
}

extension LibraryViewController: LibraryViewControllerProtocol {
    
    func dismissView() {
        dismiss(animated: true,
                completion: nil)
    }
    
    
    func didTapOpenBook(book: Book) {
        let bookViewPresenter = BookViewPresenter()
        let bookProfileViewController = BookProfileViewController(output: bookViewPresenter, book: book)
        navigationController?.pushViewController(bookProfileViewController, animated: true)
        navigationController?.navigationBar.tintColor = .black
        //bookViewPresenter.view = bookProfileViewController
    }
    
    func reloadTable() {
        self.booksTableView.reloadData()
    }
    
    func didTapOpenAddNewBook() {
        
        let addNewBookPresenter = AddNewBookPresenter()
        let addNewBookViewController = AddNewBookViewController(presenter: addNewBookPresenter)
        let navigationController = UINavigationController(rootViewController: addNewBookViewController)
        addNewBookPresenter.view = addNewBookViewController
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController,
                animated: true,
                completion: nil)
        
    }
}

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return books.count
        return self.presenter.currentBooks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableCell", for: indexPath) as? BookTableCell else {
            return .init()
        }
        
        cell.selectionStyle = .none
//        let book = books[indexPath.row]
        let book = self.presenter.currentBooks[indexPath.row]
        cell.configure(with: book)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let book = books[indexPath.row]
        let book = self.presenter.currentBooks[indexPath.row]
        presenter.didTapOpenBook(book: book)
    }
    
}

