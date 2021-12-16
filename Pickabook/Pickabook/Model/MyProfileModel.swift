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
    var phoneNumber: Int?
    var email: String
    var telegramLink: String?
    var instagramLink: String?
    
    //let bookList: [Book]? // под вопросом
    //let about: String?
    //let favouriteGenre
    //let adress
    //let metroStation
    
    init(id: String, name: String, photoName: String?, photo: UIImage?, phoneNumber: Int?, email: String?, telegramLink: String?, instagramLink: String?) {
        
        self.id = ""//= Auth.auth().currentUser!.uid
        self.name = "Init Data"
        self.photoName = nil
        self.photo = nil
        self.phoneNumber = 404
        self.email = "From MyProfileModel"
        self.telegramLink = nil
        self.instagramLink = nil
        
    }

}
