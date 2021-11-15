//
//  MainViewController.swift
//  Pickabook
//
//  Created by Ульяна Цимбалистая on 13.11.2021.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let genrePresenter = GenreCollectionViewPresenter()
        let genresVC = UINavigationController(rootViewController: GenreCollectionViewController(output: genrePresenter))
        genresVC.tabBarItem.image = UIImage(named: "SearchViewIcon")
        genresVC.title = ""
        
        let profileVC = TestProfileVC()
        profileVC.tabBarItem.image = UIImage(named: "ProfileViewIcon")
        profileVC.title = ""
        
        let favoritesVC = TestFavVC()
        favoritesVC.tabBarItem.image = UIImage(named: "FavViewIcon")
        favoritesVC.title = ""
        
        let addPresenter = AddNewBookPresenter()
   //     let addRouter = AddNewBookRouter()
        let addViewController = AddNewBookViewController(output: addPresenter)
        let addVC = UINavigationController(rootViewController: addViewController)
        addPresenter.view = addViewController
   //     addPresenter.router = addRouter
        addVC.tabBarItem.image = UIImage(named: "AddViewIcon")
        addVC.title = ""
        
        self.setViewControllers([genresVC, favoritesVC, addVC, profileVC], animated: false)
        self.modalPresentationStyle = .fullScreen
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .black
        
        self.tabBarItem.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    
    class TestProfileVC : UIViewController{
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.backgroundColor = .systemPurple
            
        }
    }
    
    class TestFavVC : UIViewController{
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.backgroundColor = .systemPink
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}