//
//  MyProfileModel.swift
//  Pickabook
//
//  Created by Даниил Найко on 08.11.2021.
//

import Foundation
import UIKit


struct Profile {
    let id: Int
    let name: String
    let photo: URL?
    let about: String?
    let phoneNumber: String? //should be changed
    let mailAdress: String?
    let telegramLink: URL?
    let instagramLink: URL?
    let bookList: [Book]?
    //let favouriteGenre
}

//struct Book {
//    var bookImages: [UIImage] = []
//    var bookName: String
//    var bookAuthor: String
//    var bookGenreId: Int
//    var bookCondition: Int
//    var bookDescription: String?
//    var bookLanguage: String


class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookImage: UIImage!
    //@IBOutlet weak var productImageView: NetworkImageView!
    //@IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = .white
        backgroundColor = .systemGray5
        //productImageView.contentMode = .scaleAspectFill
    }

    func configure(with book: Book) {
        
        bookName.text = book.bookName
        bookAuthor.text = book.bookAuthor
        bookImage = book.bookImages[0]
        
        //priceLabel.text = book.price
        //favoriteButton.setImage(UIImage(named: book.isFavorite ? "favoriteActive" : "favoriteInactive"), for: .normal)
        
    }
}
