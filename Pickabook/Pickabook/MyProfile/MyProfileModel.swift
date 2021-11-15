//
//  MyProfileModel.swift
//  Pickabook
//
//  Created by Даниил Найко on 08.11.2021.
//

import Foundation
import UIKit


struct Profile {
    let id: Int // let id: String = UUID().uuidString
    let name: String
    let photo: URL?
    let about: String?
    let phoneNumber: String? //should be changed
    let mailAdress: String?
    let telegramLink: URL?
    let instagramLink: URL?
    let bookList: [Book]?
    //let favouriteGenre
    //let adress
    //let metroStation
}

//struct Book {
//    var bookImages: [UIImage] = []
//    var bookName: String
//    var bookAuthor: String
//    var bookGenreId: Int
//    var bookCondition: Int
//    var bookDescription: String?
//    var bookLanguage: String
