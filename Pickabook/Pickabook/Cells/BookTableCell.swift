//
//  MyProfileBookListCell.swift
//  Pickabook
//
//  Created by Даниил Найко on 14.11.2021.
//

import Foundation
import UIKit
import PinLayout

class BookTableCell: UITableViewCell {
    
    //struct Book {
    //    var bookImages: [UIImage] = []
    //    var bookName: String
    //    var bookAuthor: String
    //    var bookGenreId: Int
    //    var bookCondition: Int
    //    var bookDescription: String?
    //    var bookLanguage: String
    
    let bookImage = UIImageView() //= UIImage() //need fix
    let bookNameLabel = UILabel()
    let bookAuthorLabel = UILabel()
    
    //  can be added (look comments down)
    //    let bookConditionLabel = UILabel()
    //    let bookConditionIcon  = UILabel() //= UIImage() //need fix
    
    func configure(with book: Book) {
        // Картинка книги
        bookImage.contentMode = UIView.ContentMode.scaleAspectFill
        // Если картинки нет или она не грузится, то ставим картинку по умолчанию
        if (book.bookImages.count == 0){
            bookImage.image = UIImage(named: "default")
        } else {
            bookImage.image = UIImage(data: book.bookImages[0])
        }
        
        bookNameLabel.text = book.bookName
        bookAuthorLabel.text = book.bookAuthor
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        bookImage.backgroundColor = UIColor.purple
        bookImage.layer.cornerRadius = 20
        bookImage.layer.masksToBounds = true
        contentView.addSubview(bookImage)
        
        bookNameLabel.font = bookNameLabel.font.withSize(16)
        contentView.addSubview(bookNameLabel)
        
        bookAuthorLabel.font = bookAuthorLabel.font.withSize(14)
        contentView.addSubview(bookAuthorLabel)
        
        //        bookConditionLabel.textAlignment = .center
        //        bookConditionLabel.font = bookConditionLabel.font.withSize(12)
        //        //bookConditionLabel.text = "4.6"
        //        contentView.addSubview(bookConditionLabel)
        
        //        bookConditionIcon.backgroundColor = UIColor.yellow
        //        contentView.addSubview(bookConditionIcon)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //высота строки выставлена 100 в extension viewcontroller'а
        
        bookImage.pin
            .top(10)
            .left(10)
            .size(80)
        
        bookNameLabel.pin
            .top(26)
            .right(of: bookImage, aligned: .top).marginLeft(10)
            .height(20)
            .right(10)
        
        bookAuthorLabel.pin
            .below(of: bookNameLabel).marginTop(8)
            .right(of: bookImage, aligned: .top).marginLeft(10)
            .height(20)
            .right(10)
        
        //        bookConditionLabel.pin
        //            .below(of: bookAuthorLabel)
        //            .right(of: bookImage).marginLeft(10)
        //            .size(20)
        
        //        bookConditionIcon.pin
        //            //.bottomRight()
        //            .below(of: bookAuthorLabel)
        //            .right(of: bookConditionLabel)
        //            .size(20)
        
    }
    
}
