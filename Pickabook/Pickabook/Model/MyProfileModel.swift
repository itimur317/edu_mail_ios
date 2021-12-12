//
//  MyProfileModel.swift
//  Pickabook
//
//  Created by Даниил Найко on 08.11.2021.
//
import Foundation
import UIKit
import Firebase

struct Profile {
    //let id: Int // let id: String = UUID().uuidString
    let name: String
    let photo: URL?
    let about: String?
    let phoneNumber: Int? //should be changed
    //let mailAdress: String?
    let telegramLink: URL?
    let instagramLink: URL?
    let bookList: [Book]?
    
    let email: String
    //let password: String //need changes
    
    //let favouriteGenre
    //let adress
    //let metroStation
}

struct User {
    let uid: String
    let email: String

    init(user: Firebase.User){
        self.uid = user.uid
        self.email = user.email!
    }
}
