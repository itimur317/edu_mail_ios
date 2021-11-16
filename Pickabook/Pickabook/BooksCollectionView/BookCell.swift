//
//  BookCellCollectionViewCell.swift
//  Pickabook
//
//  Created by Ульяна Цимбалистая on 14.11.2021.
//

import UIKit

class BookCell: UICollectionViewCell {
    let bookImageView : UIImageView = {
        let bookImageView = UIImageView()
        bookImageView.frame.size = CGSize(width: 70, height: 70)
        bookImageView.image = UIImage(named: "default")
        bookImageView.layer.cornerRadius = 15
        bookImageView.layer.masksToBounds = true
        
        return bookImageView
    }()
    
    let bookNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .left
        label.textColor = .black
        
        return label
    }()
    
    let bookAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .left
        label.textColor = .black
        
//        label.numberOfLines = 0
//        label.lineBreakMode = .byWordWrapping
//        label.sizeToFit()
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with book: Book) {
        bookNameLabel.text = book.bookName
        bookAuthorLabel.text = book.bookAuthor
    }
    
    func addView(){
        addSubview(bookNameLabel)
        addSubview(bookAuthorLabel)
        addSubview(bookImageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        bookImageView.pin
            .top(10)
            .left(5)
            .size(80)
        
        bookNameLabel.pin
            .top(26)
            .right(of: bookImageView, aligned: .top).marginLeft(10)
            .height(20)
            .right(10)
        
        bookAuthorLabel.pin
            .below(of: bookNameLabel).marginTop(8)
            .right(of: bookImageView, aligned: .top).marginLeft(10)
            .height(20)
            .right(10)
    }
}
