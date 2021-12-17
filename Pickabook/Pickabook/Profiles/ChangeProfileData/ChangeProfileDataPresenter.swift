//
//  ChangeProfileDataPresenter.swift
//  Pickabook
//
//  Created by Даниил Найко on 15.11.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase
//output
protocol ChangeProfileDataViewControllerProtocol: AnyObject {
    func openSavedPhotosAlbum()
    func reloadMyProfile(myProfile: Profile)
    func didTapSaveButton()
    //func presentProfile(profiles: [Profile])
    //func presentAlert(title: String, message: String)
    //var bookList: [Book]? { get }
    /*  func setBookAuthor(author: String)
    func setBookGenres(genres: [Int])
    func setBookCondition(condition: Int)
    func setBookDescription(description: String?)
    func setBookLanguage(language: String)*/
}
 
protocol ChangeProfileDataPresenterProtocol: AnyObject {
    var myProfile: Profile { get set }
    func observeMyProfile()
    
    func didTapAddPhotoButton()
    func replaceDatabaseData(with newData : Profile)
    func setViewDelegate(delegate: ChangeProfileDataViewControllerProtocol)
}
 
 
final class ChangeProfileDataPresenter: ChangeProfileDataPresenterProtocol {
    
    weak var view: ChangeProfileDataViewControllerProtocol?
    private let database = Firestore.firestore()
    
    var myProfile: Profile = Profile.init(id: "", name: "", photoName: "", photo: nil, phoneNumber: "", email: "", telegramLink: "", instagramLink: "")
    
    func observeMyProfile() {
        UserManager.shared.output = self
        guard let MyId = Auth.auth().currentUser?.uid else { return }
        UserManager.shared.observeUser(userId: MyId)
    }
    
    public func setViewDelegate(delegate: ChangeProfileDataViewControllerProtocol) {
        self.view = delegate
    }
    
    func didTapAddPhotoButton() {
        self.view?.openSavedPhotosAlbum()
    }
 
    func replaceDatabaseData(with newData: Profile) {
        
//        guard let MyId = Auth.auth().currentUser?.uid else { return }
//        var key : String = ""
//        
//        let ref = Database.database().reference().root.child("Users").observe(DataEventType.value, with: { (snapshot) in
//                
//                if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
//                    print("SNAPSHOT: \(snapshot)")
//                    for snap in snapshot {
//                        if let userDict = snap.value as? Dictionary<String, AnyObject> {
//                            if userDict["id"] as? String == MyId {
//                                key = snap.key
//                                print(key)
//                                //Add this key to userID array
//                            }
//                        }
//                    }
//                }
//            }
//        )
//                                                                                            
//        var ref2 = Database
//            .database()
//            .reference()
//            .root
//            .child("Users")
//            .child(key)
//            .updateChildValues(["name" : newData.name,
//                                "phoneNumber" : newData.phoneNumber ?? nil,
//                                "email" : newData.email,
//                                "telegramLink" : newData.telegramLink ?? nil,
//                                "instagramLink" : newData.instagramLink ?? nil])
            
                                                                       
                                    
                                        
//            .queryOrdered(byChild: "id").queryEqual(toValue: MyId)
//
//        let UserRealId = ref.push().getKey();
//
//        ref.observe(.value, with: DataSnapshot) in {
//
//        }
//
//        ref = Database.parent
//            .updateChildValues(["name" : newData.name,
//                                "phoneNumber" : newData.phoneNumber ?? nil,
//                                "email" : newData.email,
//                                "telegramLink" : newData.telegramLink ?? nil,
//                                "instagramLink" : newData.instagramLink ?? nil])
//
//        ref .child('users')
//            .orderByChild('name')
//            .equalTo('John Doe')
//            .on("value", function(snapshot)
//
//
//
//        if newData.photo != nil {
//
//            let imageLoader: ImageLoaderProtocol = ImageLoader()
//            guard let data = newData.photo?.jpegData(compressionQuality: 0.1) else { return }
//
//            imageLoader.uploadImage(imageData: [data]) { [weak self] imageURLs, imageNames in
//
                
    //            photoName = imageNames
    //            photoURL = imageURLs
                
    //            var dictForDatabase : [String : Any]
    //            dictForDatabase = ["id" : MyId,
    //                               "name" : newData.name,
    //                               "phoneNumber" : newData.phoneNumber ?? nil,
    //                               "email" : newData.email,
    //                               "telegramLink" : newData.telegramLink ?? nil,
    //                               "instagramLink" : newData.instagramLink ?? nil,
    //                               "photoName" : imageNames,
    //                               "photoURL" : imageURLs]
                
//                dataSnapshot.getKey()
//                //let uid = FirebaseAuth. getInstance().getCurrentUser().getUid()
//                let ref = Database
//                    .database()
//                    .reference()
//                    .root
//                    .child("Users")
//                    .child(uid)
//                    .updateChildValues(["photoName" : imageNames,
//                                        "photoURL" : imageURLs])
//
//                self?.database.collection("Users").addDocument(data: dictForDatabase) { [weak self] error in
//                    if let error = error { print("Error writing document: \(error)") }
//                    else {
//                        print("Document successfully written!")
//                        //self?.output?.didCreate(user)
//                    }
//                }
//
//            }
//        }
    }
 
}

extension ChangeProfileDataPresenter : UserManagerOutput {
    
    func didFail(with error: Error) {
        //
    }
    
    func didRecieve(_ user: Profile) {
        print ("didRecieve IN WORK")
        print (user)
        self.view?.reloadMyProfile(myProfile: user)
    }
    
    func didCreate(_ user: Profile) { }
    
}
