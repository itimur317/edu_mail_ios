//
//  AddBook.swift
//  Pickabook
//
//  Created by Timur on 05.11.2021.
//

import Foundation


struct RGBColor{
    let redColor: Float
    let greenColot: Float
    let blueColor: Float
    let alpha: Float
}


struct Book {
   // array of photos
   let bookName: String?
  /* let bookAuthor: String?
   let bookGenres: [Int]?
   let bookCondition: Int?
   let bookDescription: String?
   let bookLanguage: String?*/
}

var myCol = RGBColor(redColor: 0.18, greenColot: 0.19, blueColor: 0.38, alpha: 1.00)

let dictOfGenres: [String : RGBColor] = ["Бестселлеры" : myCol, "Психология" : myCol,"Искусство" : myCol,"Бизнес" : myCol,"Классика" : myCol,"Комиксы" : myCol,"Детективы" : myCol,"Хобби/путешествия" : myCol,"Научно-популярное" : myCol,"Здоровье/спорт" : myCol,"Красота" : myCol,"Детские книги" : myCol,"Философия и религия" : myCol,"Научное и учебное" : myCol,"Биография" : myCol,"Другое" : myCol]


