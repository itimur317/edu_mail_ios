//
//  LibraryPresenter.swift
//  Pickabook
//
//  Created by Timur on 19.11.2021.
//

import Foundation

protocol LibraryPresenterProtocol : AnyObject {
    var currentBooks : [Book] { get set }
    func dismissView()
    func didTapOpenAddNewBook()
    func didTapOpenBook(book: Book)
    func loadBooks()
}

final class LibraryPresenter : LibraryPresenterProtocol {
    
    weak var view : LibraryViewControllerProtocol?
    var currentBooks : [Book] = []
    
    func didTapOpenBook(book: Book) {
        self.view?.didTapOpenBook(book: book)
    }
    
    
    func dismissView() {
        self.view?.dismissView()
    }
    
    
    func didTapOpenAddNewBook() {
        self.view?.didTapOpenAddNewBook()
    }
    
    func loadBooks() {
        BookManager.shared.output = self
        BookManager.shared.observeBooks()
    }


    // deleting row :
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction: UITableViewRowAction, indexPath: IndexPath) -> Void in
//            print("Deleted")
//            self.catNames.remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
//            self.tableView.reloadData()
//        }
//    }

}


extension LibraryPresenter : BookManagerOutput {
    func didRecieve(_ books: [Book]) {
        currentBooks = books
        self.view?.reloadTable()
    }
    
    func didCreate(_ book: Book) {
        //
    }
    
    func didFail(with error: Error) {
        //
    }
    
    
}
