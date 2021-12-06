//
//  LibraryPresenter.swift
//  Pickabook
//
//  Created by Timur on 19.11.2021.
//

import Foundation

protocol LibraryPresenterProtocol : AnyObject {
    func dismissView()
    func didTapOpenAddNewBook()
    func didTapOpenBook(book: Book)
}

final class LibraryPresenter : LibraryPresenterProtocol {
    
    weak var view : LibraryViewControllerProtocol?
    
    func didTapOpenBook(book: Book) {
        self.view?.didTapOpenBook(book: book)
    }
    
    
    func dismissView() {
        self.view?.dismissView()
    }
    
    
    func didTapOpenAddNewBook() {
        self.view?.didTapOpenAddNewBook()
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
