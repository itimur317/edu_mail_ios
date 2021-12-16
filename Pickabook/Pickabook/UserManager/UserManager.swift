//
//  UserManager.swift
//  Pickabook
//
//  Created by Даниил Найко on 14.12.2021.
//

import Foundation
import FirebaseFirestore
//import FirebaseAuth
import UIKit

protocol UserManagerProtocol {
    
    var output: UserManagerOutput? { get set }
    func findUser(userId : String) -> Profile
    func observeUser(userId : String)
    func create(user: Profile)
    
    //func delete(user: Profile)
    
}


protocol UserManagerOutput : AnyObject {
    
    func didRecieve(_ user: Profile)
    func didCreate(_ user: Profile)
    func didFail(with error: Error)
    
    //func didDelete(_ user: Profile)
    
}

final class UserManager : UserManagerProtocol {
    
    static var shared: UserManagerProtocol = UserManager()
    weak var output: UserManagerOutput?
    
    private var user: Profile = Profile(id: "", name: "", photoName: "", photo: nil, phoneNumber: nil, email: "", telegramLink: "", instagramLink: "")
    
    private let database = Firestore.firestore()
    private let userConverter = ProfileDataConverter()
    
    let imageLoader: ImageLoaderProtocol = ImageLoader()
    
    func create(user: Profile) {
        let imageLoader: ImageLoaderProtocol = ImageLoader()
        
        guard let data = user.photo?.jpegData(compressionQuality: 0.1) else { return }
        
        imageLoader.uploadImage(imageData: [data]) { [weak self] imageURLs, imageNames in
            //if user.userImages.count == imageURLs.count {
            
            var dictForDatabase : [String : Any]
            dictForDatabase = ["id" : user.id,
                               "name" : user.name,
                               "phoneNumber" : user.phoneNumber ?? nil,
                               "email" : user.email,
                               "telegramLink" : user.telegramLink ?? nil,
                               "instagramLink" : user.instagramLink ?? nil,
                               "photoName" : imageNames,
                               "photoURL" : imageURLs]
            
            self?.database.collection("Users").addDocument(data: dictForDatabase) { [weak self] error in
                if let error = error {
                    print("Error writing document: \(error)")
                    self?.output?.didFail(with: error)
                }
                else {
                    print("Document successfully written!")
                    self?.output?.didCreate(user)
                }
            }
        }
    }
    
    func observeUser(userId : String){
        self.database.collection("Users").whereField("id", isEqualTo: userId).addSnapshotListener { [weak self] querySnapshot, error in
            
            if let error = error {
                print (error)
                self?.output?.didFail(with: error)
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("query")
                self?.output?.didFail(with: NetworkError.unexpected)
                return
            }
            
            var user = (self?.userConverter.profileData(from: documents[0]))!
            
            let defaultProfile : Profile = Profile.init(id: "", name: "", photoName: "", photo: nil, phoneNumber: nil, email: "", telegramLink: "", instagramLink: "")
            print ("\(user)")
            print ("\(defaultProfile)") //почему-то грузится именно дефолтный юзер
            self?.output?.didRecieve(user ?? defaultProfile)
            
            self?.user = user ?? defaultProfile
  
            guard let name = user.photoName else {return}
            self?.imageLoader.getImage(with: name) { [weak self] (result) in
                switch result {
                case .success(let data):
                    user.photo = UIImage(data: data)
                    self?.output?.didRecieve(user ?? defaultProfile)
                    //print(user?.photoName)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func findUser(userId : String) -> Profile{
        var owner : Profile =  Profile.init(id: "", name: "", photoName: "", photo: nil, phoneNumber: nil, email: "", telegramLink: "", instagramLink: "")
        print(userId)
        self.database.collection("Users").whereField("id", isEqualTo: userId).addSnapshotListener { [weak self] querySnapshot, error in
  
            if let error = error {
                print (error)
                self?.output?.didFail(with: error)
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("query")
                self?.output?.didFail(with: NetworkError.unexpected)
                return
            }
            
            owner = (self?.userConverter.profileData(from: documents[0]))!
            
            let defaultProfile : Profile = Profile.init(id: "", name: "", photoName: "", photo: nil, phoneNumber: nil, email: "", telegramLink: "", instagramLink: "")
            print ("\(owner)")
            print ("\(defaultProfile)") //почему-то грузится именно дефолтный юзер
  
            guard let name = owner.photoName else {return}
            self?.imageLoader.getImage(with: name) { [weak self] (result) in
                switch result {
                case .success(let data):
                    owner.photo = UIImage(data: data)
                    //print(user?.photoName)
                case .failure(let error):
                    print(error)
                }
            }
        }
        return owner
    }
}

private final class ProfileDataConverter {
    
    enum Key: String {
        case email
        case id
        case instagramLink
        case name
        case phoneNumber
        case photoName
        case photoURL
        case telegramLink
    }
    
    func profileData (from document: DocumentSnapshot) -> Profile? {
        guard let dict = document.data(),
              let id = dict[Key.id.rawValue] as? String,
              let name = dict[Key.name.rawValue] as? String,
              let email = dict[Key.email.rawValue] as? String
//            let photoName = dict[Key.photoName.rawValue] as? String
            else {
                print("return nil")
                return nil
                }
        
        var phoneNumber = dict[Key.phoneNumber.rawValue] as? String
        var telegramLink = dict[Key.telegramLink.rawValue] as? String
        var instagramLink = dict[Key.instagramLink.rawValue] as? String
        
        if dict[Key.phoneNumber.rawValue] == nil { phoneNumber = "" }
        if dict[Key.telegramLink.rawValue] == nil { telegramLink = "" }
        if dict[Key.instagramLink.rawValue] == nil { instagramLink = "" }
        //let photoURL = dict[Key.photoURL.rawValue] as? String
        //let photo = UIImage.init(data: photo1)
        let profileDataResult = Profile(id: id, name: name, photoName: nil, photo: nil, phoneNumber: phoneNumber, email: email, telegramLink: telegramLink, instagramLink: instagramLink)
        return profileDataResult
    }
    
}
