//
//  GenreCollectionViewPresenter.swift
//  Pickabook
//
//  Created by Ульяна Цимбалистая on 08.11.2021.
//

import UIKit

protocol GenreCollectionViewPresenterProtocol: AnyObject {
    var genres: [Genre] { get }
    func chosedGenre(genre: Genre)
}

final class GenreCollectionViewPresenter: GenreCollectionViewPresenterProtocol {
    func chosedGenre(genre: Genre) {
        print("tabbed \(genre.name)")
    }
    
//    weak var view: GenreCollectionViewController?
     var genres = [
        Genre(
            name: "Бестселлеры",
            color: UIColor(red: 1.00, green: 0.89, blue: 0.37, alpha: 1.00)),
        Genre(
            name: "Искусство",
            color : UIColor(red: 0.62, green: 0.85, blue: 0.82, alpha: 1.00)),
        Genre(
            name: "Фэнтези",
            color : UIColor(red: 0.53, green: 0.20, blue: 0.56, alpha: 1.00)),
        Genre(
            name: "Психология" ,
            color: UIColor(red: 1.00, green: 0.38, blue: 0.24, alpha: 1.00)),
        Genre(
            name: "Детективы",
            color :  UIColor(red: 0.18, green: 0.19, blue: 0.38, alpha: 1.00)),
        Genre(
            name: "Фантастика",
            color : UIColor(red: 0.71, green: 0.75, blue: 0.93, alpha: 1.00)),
        Genre(
            name: "Романы",
            color :  UIColor(red: 0.92, green: 0.40, blue: 0.50, alpha: 1.00)),
        Genre(
            name: "Бизнес",
            color: UIColor(red: 0.99, green: 0.53, blue: 0.16, alpha: 1.00)),
        Genre(
            name: "Классика" ,
            color: UIColor(red: 0.39, green: 0.42, blue: 0.71, alpha: 1.00)),
        Genre(
            name: "Комиксы",
            color : UIColor(red: 0.79, green: 0.79, blue: 0.04, alpha: 1.00)),
        Genre(
            name: "Хобби и \nпутешествия",
            color : UIColor(red: 0.23, green: 0.16, blue: 0.80, alpha: 1.00)),
        Genre(
            name: "Биография",
            color : UIColor(red: 0.64, green: 0.04, blue: 0.22, alpha: 1.00)),
        Genre(
            name: "Поэзия",
            color : UIColor(red: 1.00, green: 0.66, blue: 0.18, alpha: 1.00)),
        Genre(
            name: "Научно-\nпопулярное",
            color : UIColor(red: 0.78, green: 0.84, blue: 0.43, alpha: 1.00)),
        Genre(
            name: "Здоровье и спорт",
            color : UIColor(red: 1.00, green: 0.45, blue: 0.62, alpha: 1.00)),
        Genre(
            name: "Детские книги",
            color : UIColor(red: 0.96, green: 0.75, blue: 0.82, alpha: 1.00)),
            ]
}




