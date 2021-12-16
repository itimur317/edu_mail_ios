//
//  MyProfileModel.swift
//  Pickabook
//
//  Created by Даниил Найко on 08.11.2021.
//
import Foundation
import UIKit
import FirebaseAuth

struct Profile {
    
    var id: String// let id: String = UUID().uuidString
    var name: String
    var photoName: String? //URL?
    var photo: UIImage?
    var phoneNumber: String?//Int?
    var email: String?
    var telegramLink: String?
    var instagramLink: String?
    
    //let bookList: [Book]? // под вопросом
    //let about: String?
    //let favouriteGenre
    //let adress
    //let metroStation
    
    init(id: String, name: String, photoName: String?, photo: UIImage?, phoneNumber: String?, email: String?, telegramLink: String?, instagramLink: String?) {
        
        self.id = id
        self.name = name
        self.photoName = photoName
        let nul = UIImage(named: "default")
        print("in  model: \(photo ?? nul)")
        self.photo = UIImage(named: "default") // to do
        self.phoneNumber = phoneNumber
        self.email = email
        self.telegramLink = telegramLink
        self.instagramLink = instagramLink
        
    }

}
