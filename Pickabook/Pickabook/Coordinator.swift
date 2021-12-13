//
//  Coordinator.swift
//  Pickabook
//
//  Created by Даниил Найко on 13.12.2021.
//

import Foundation
import UIKit

class Coordinator {
    static func rootVC(vc: UIViewController) {
        let sceneDelegate = UIApplication.shared.connectedScenes
                .first!.delegate as! SceneDelegate
        //sceneDelegate.window!.rootViewController = UINavigationController(rootViewController: vc)
        sceneDelegate.window!.rootViewController = vc
        sceneDelegate.window!.makeKeyAndVisible()
    }
}
