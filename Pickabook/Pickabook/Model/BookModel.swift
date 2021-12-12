//
//  Model.swift
//  Pickabook
//
//  Created by Timur on 14.11.2021.
//
import Foundation
import UIKit

struct Book {
    var identifier : String? = UUID().uuidString
    var bookImagesUrl : [String]?
    var bookImages: [Data] 
    var bookName: String
    var bookAuthor: String
    var bookGenres: Genre
    var bookCondition: Int
    var bookDescription: String?
    var bookLanguage: String
}

