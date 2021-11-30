//
//  CustomCell.swift
//  Pickabook
//
//  Created by Ульяна Цимбалистая on 08.11.2021.
//

import UIKit

class GenreCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 15
        addView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let namelabel = UILabel()
    
    func addView(){
        namelabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        namelabel.textAlignment = .left
        namelabel.textColor = UIColor.white
        
        namelabel.numberOfLines = 0
        namelabel.lineBreakMode = .byWordWrapping
        
        namelabel.frame.size = CGSize(width: self.frame.width - 20,  height: 60)
        
        namelabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(namelabel)
        
        namelabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        namelabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        namelabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    func configure(genre: Genre){
        namelabel.text = genre.name
        backgroundColor = genre.color
    }
}
