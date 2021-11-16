//
//  GenreCollectionViewPresenter.swift
//  Pickabook
//
//  Created by Ульяна Цимбалистая on 08.11.2021.
//

import UIKit

protocol GenreCollectionViewPresenterProtocol: AnyObject {
    func chosedGenre(genre: Genre)
}


final class GenreCollectionViewPresenter: GenreCollectionViewPresenterProtocol {
    weak var delegate : GenreCollectionViewController?
    
    public func setViewDelegate(delegate: GenreCollectionViewController) {
        self.delegate = delegate
    }
    
    func chosedGenre(genre: Genre) {
        print("tabbed \(genre.name)")
        delegate?.presentNextVC(genre: genre)
    }
}




