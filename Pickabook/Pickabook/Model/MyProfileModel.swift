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
    
    var id: String = Auth.auth().currentUser!.uid// let id: String = UUID().uuidString
    var name: String
    var photoName: String? //URL?
    var photo: UIImage?
    var phoneNumber: Int?
    var email: String
    var telegramLink: URL?
    var instagramLink: URL?
    
    //let bookList: [Book]? // под вопросом
    //let about: String?
    //let favouriteGenre
    //let adress
    //let metroStation
    
    init(id: String, name: String, photoName: String?, photo: UIImage?, phoneNumber: Int?, email: String?, telegramLink: URL?, instagramLink: URL?) {
        
        self.id = Auth.auth().currentUser!.uid
        self.name = ""
        self.photoName = nil
        self.photo = nil
        self.phoneNumber = 0
        self.email = ""
        self.telegramLink = nil
        self.instagramLink = nil
        
    }

}
