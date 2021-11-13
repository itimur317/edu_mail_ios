//
//  AddBook.swift
//  Pickabook
//
//  Created by Timur on 05.11.2021.
//
import Foundation
import UIKit



struct Book {
    var bookImages: [UIImage] = []
    var bookName: String
    var bookAuthor: String
    var bookGenreId: Int
    var bookCondition: Int
    var bookDescription: String?
    var bookLanguage: String
}


let arrayOfGenres: [(genre: String, colorOfGenre : UIColor)] = [("Бестселлеры", UIColor(red: 1.00, green: 0.89, blue: 0.37, alpha: 1.00)), ("Психология" ,  UIColor(red: 1.00, green: 0.38, blue: 0.24, alpha: 1.00)),("Искусство" , UIColor(red: 0.62, green: 0.85, blue: 0.82, alpha: 1.00)),("Бизнес" , UIColor(red: 0.99, green: 0.53, blue: 0.16, alpha: 1.00)),("Классика" , UIColor(red: 0.39, green: 0.42, blue: 0.71, alpha: 1.00)),("Комиксы" , UIColor(red: 0.79, green: 0.79, blue: 0.04, alpha: 1.00)),("Детективы" , UIColor(red: 0.18, green: 0.19, blue: 0.38, alpha: 1.00)),("Хобби/путешествия" , UIColor(red: 0.71, green: 0.75, blue: 0.93, alpha: 1.00)),("Научно-популярное" , UIColor(red: 0.53, green: 0.20, blue: 0.56, alpha: 1.00)),("Здоровье/спорт" , UIColor(red: 0.92, green: 0.40, blue: 0.50, alpha: 1.00)),("Красота" , UIColor(red: 0.08, green: 0.48, blue: 0.43, alpha: 1.00)),("Детские книги" , UIColor(red: 0.45, green: 0.45, blue: 0.67, alpha: 1.00)),("Философия и религия" , UIColor(red: 0.42, green: 0.06, blue: 0.10, alpha: 1.00)),("Научное и учебное" , UIColor(red: 0.47, green: 0.70, blue: 0.55, alpha: 1.00)),("Биография" , UIColor(red: 0.96, green: 0.75, blue: 0.82, alpha: 1.00)),("Другое" , UIColor(red: 0.93, green: 0.72, blue: 0.55, alpha: 1.00))]


