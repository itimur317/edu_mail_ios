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
    let id: String // let id: String = UUID().uuidString
    let name: String
    let photo: URL?
    //let about: String?
    let phoneNumber: Int? //should be changed
    let email: String?
    let telegramLink: URL?
    let instagramLink: URL?
    //let bookList: [Book]? // под вопросом
    
    //let favouriteGenre
    //let adress
    //let metroStation
    
    init(id: Int, name: String, photo: URL?, phoneNumber: Int?, email: String?, telegramLink: URL?, instagramLink: URL? /*, bookList: [Book]?*/) {
        
        //self.id = FIRAuth.auth()!.currentUser!.uid
        self.id = Auth.auth().currentUser!.uid
        self.name = ""
        self.photo = nil
        self.phoneNumber = 0
        self.email = ""
        self.telegramLink = nil
        self.instagramLink = nil
        //self.bookList = nil
    }

}

//struct User {
//    let uid: String
//    let email: String
//
//    init(user: Firebase.User){
//        self.uid = user.uid
//        self.email = user.email!
//    }
//}
//
//let user = Auth.auth().currentUser
//if let user = user {
//  // The user's ID, unique to the Firebase project.
//  // Do NOT use this value to authenticate with your backend server,
//  // if you have one. Use getTokenWithCompletion:completion: instead.
//  let uid = user.uid
//  let email = user.email
//  let photoURL = user.photoURL
//  var multiFactorString = "MultiFactor: "
//  for info in user.multiFactor.enrolledFactors {
//    multiFactorString += info.displayName ?? "[DispayName]"
//    multiFactorString += " "
//  }
//  // ...
//}
