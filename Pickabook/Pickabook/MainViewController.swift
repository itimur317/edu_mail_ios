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
        
        let presenter = GenreCollectionViewPresenter()
        let genresVC = UINavigationController(rootViewController: GenreCollectionViewController(output: presenter))
        genresVC.tabBarItem.image = UIImage(named: "SearchViewIcon")
        genresVC.title = ""
        
        let profileVC = TestProfileVC()
        profileVC.tabBarItem.image = UIImage(named: "ProfileViewIcon")
        profileVC.title = ""
        
        let favoritesVC = TestFavVC()
        favoritesVC.tabBarItem.image = UIImage(named: "FavViewIcon")
        favoritesVC.title = ""
        
        
        let addVC = TestAddVC()
        addVC.tabBarItem.image = UIImage(named: "AddViewIcon")
        addVC.title = ""
        
        self.setViewControllers([genresVC, favoritesVC, addVC, profileVC], animated: false)
        
        self.modalPresentationStyle = .fullScreen
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .black
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
    
    class TestAddVC : UIViewController{
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.backgroundColor = .systemTeal
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
