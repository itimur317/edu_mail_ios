//
//  Model.swift
//  Pickabook
//
//  Created by Timur on 14.11.2021.
//
import Foundation
import UIKit

struct Book {
    var identifier : String = UUID().uuidString
    var bookImages: [UIImage]? = []
    var bookName: String
    var bookAuthor: String
    var bookGenres: GenreType
    var bookCondition: Int
    var bookDescription: String?
    var bookLanguage: String
}

