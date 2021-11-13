//
//  MyProfileViewController.swift
//  Pickabook
//
//  Created by Даниил Найко on 08.11.2021.
//

import UIKit
import PinLayout 

//UITableViewDelegate, UITableViewDataSource
class MyProfileViewController : UIViewController, MyProfileViewControllerProtocol {
    
    func presentProfile(profiles: [Profile]) {
        //
    }
    
    func presentAlert(title: String, message: String) {
        //
    }
    
    var output: MyProfilePresenterProtocol

    init(output: MyProfilePresenterProtocol){
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let testLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Мой профиль"
        
        testLabel.text = "жук мухожук"
        view.addSubview(testLabel)
    }
    

//    private let tableView: UITableView = {
//        let table = UITableView()
//        table.register(UITableView.self, forCellReuseIdentifier: "cell")
//    }()
//
//    //Table
//    view.addSubview(tableView)
//    tableView.delegate = self
//    tableView.dataSource = self
//
//    //Presenter
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tableView.frame = view.bounds
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        //ask presenter to handle a tap
//    }
}
