//
//  Model.swift
//  Pickabook
//
//  Created by Timur on 14.11.2021.
//
import Foundation
import UIKit

struct Book {
    var bookImages: [UIImage] = []
    var bookName: String
    var bookAuthor: String
    var bookGenres: [GenreType]
    var bookCondition: Int
    var bookDescription: String?
    var bookLanguage: String
}

var books : [Book] =  [
    Book(
        bookName: "Автостопом по галактике",
        bookAuthor: "Дуглас Адамс",
        bookGenres: [.bestsellers, .fantastic],
        bookCondition: 3,
        bookLanguage: "Русский"),
    Book(
        bookName: "Детективное агенство Дирка Джентли",
        bookAuthor: "Дуглас Адамс",
        bookGenres: [.bestsellers, .detectives],
        bookCondition: 2,
        bookLanguage: "Русский"),
    Book(
        bookName: "Кровь, пот и пиксели",
        bookAuthor: "Кто-то",
        bookGenres: [.art, .business],
        bookCondition: 3,
        bookLanguage: "Русский"),
    Book(
        bookName: "Я-Малала",
        bookAuthor: "Малала Юсуфзай",
        bookGenres: [.bestsellers, .biography],
        bookCondition: 3,
        bookLanguage: "Русский"),
    Book(
        bookName: "Сборник стихов",
        bookAuthor: "Анна Ахматова",
        bookGenres: [.poetry, .classic],
        bookCondition: 3,
        bookLanguage: "Русский"),
    Book(
        bookName: "Эмоциональный интеллект" ,
        bookAuthor: "Дэниел Гоулман",
        bookGenres: [.bestsellers, .scipop,.psychology],
        bookCondition: 3,
        bookLanguage: "Русский")
]

var genres = [
    Genre(
        type: .bestsellers,
        name: "Бестселлеры",
        color : UIColor(red: 1.00, green: 0.89, blue: 0.37, alpha: 1.00)),
    Genre(
        type: .art,
        name: "Искусство",
        color : UIColor(red: 0.62, green: 0.85, blue: 0.82, alpha: 1.00)),
    Genre(
        type: .fantasy,
        name: "Фэнтези",
        color : UIColor(red: 0.53, green: 0.20, blue: 0.56, alpha: 1.00)),
    Genre(
        type: .psychology,
        name: "Психология" ,
        color : UIColor(red: 1.00, green: 0.38, blue: 0.24, alpha: 1.00)),
    Genre(
        type: .detectives,
        name: "Детективы",
        color : UIColor(red: 0.18, green: 0.19, blue: 0.38, alpha: 1.00)),
    Genre(
        type: .fantastic,
        name: "Фантастика",
        color : UIColor(red: 0.71, green: 0.75, blue: 0.93, alpha: 1.00)),
    Genre(
        type: .roman,
        name: "Романы",
        color : UIColor(red: 0.92, green: 0.40, blue: 0.50, alpha: 1.00)),
    Genre(
        type: .business,
        name: "Бизнес",
        color : UIColor(red: 0.99, green: 0.53, blue: 0.16, alpha: 1.00)),
    Genre(
        type: .classic,
        name: "Классика" ,
        color : UIColor(red: 0.39, green: 0.42, blue: 0.71, alpha: 1.00)),
    Genre(
        type: .comic,
        name: "Комиксы",
        color : UIColor(red: 0.79, green: 0.79, blue: 0.04, alpha: 1.00)),
    Genre(
        type: .hobbiesntravel,
        name: "Хобби и путешествия",
        color : UIColor(red: 0.23, green: 0.16, blue: 0.80, alpha: 1.00)),
    Genre(
        type: .biography,
        name: "Биография",
        color : UIColor(red: 0.64, green: 0.04, blue: 0.22, alpha: 1.00)),
    Genre(
        type: .poetry,
        name: "Поэзия",
        color : UIColor(red: 1.00, green: 0.66, blue: 0.18, alpha: 1.00)),
    Genre(
        type: .scipop,
        name: "Научно-\nпопулярное",
        color : UIColor(red: 0.78, green: 0.84, blue: 0.43, alpha: 1.00)),
    Genre(
        type: .health,
        name: "Здоровье и спорт",
        color : UIColor(red: 1.00, green: 0.45, blue: 0.62, alpha: 1.00)),
    Genre(
        type: .kidslit,
        name: "Детские книги",
        color : UIColor(red: 0.96, green: 0.75, blue: 0.82, alpha: 1.00)),
]
