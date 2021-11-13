//
//  MyProfileModel.swift
//  Pickabook
//
//  Created by Даниил Найко on 08.11.2021.
//

import Foundation
import UIKit


struct Profile {
    let ID: Int
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
//   // array of photos
//   let bookName: String?
//  /* let bookAuthor: String?
//   let bookGenres: [Int]?
//   let bookCondition: Int?
//   let bookDescription: String?
//   let bookLanguage: String?*/
//}
