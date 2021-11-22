//
//  AddNewBookAddedPhotoView.swift
//  Pickabook
//
//  Created by Timur on 22.11.2021.
//

import Foundation
import UIKit

final class AddNewBookAddPhotoView: UIViewController {
    
    var currentPhotoImageView = UIImageView()
   
    init(_ currentImage: UIImage) {
        super.init(nibName: nil, bundle: nil)
        currentPhotoImageView.image = currentImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        let tapViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapViewGestureRecognizer(tapGestureRecognizer:)))
        view.addGestureRecognizer(tapViewGestureRecognizer)
        
        let pinchImageViewGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(didPinchImageViewGestureRecognizer(pinchGestureRecognizer:)))
        
        currentPhotoImageView.frame = CGRect(x: 20, y: view.frame.height / 2  - (view.frame.width - 40) / 2, width: view.frame.width - 40, height: view.frame.width - 40)
        currentPhotoImageView.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        currentPhotoImageView.isUserInteractionEnabled = true
        currentPhotoImageView.addGestureRecognizer(pinchImageViewGestureRecognizer)
        view.addSubview(currentPhotoImageView)
    }
    
    @objc
    func didTapViewGestureRecognizer(tapGestureRecognizer: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func didPinchImageViewGestureRecognizer(pinchGestureRecognizer: UIPinchGestureRecognizer) {
        if pinchGestureRecognizer.state == .began || pinchGestureRecognizer.state == .changed {
            self.view.bringSubviewToFront(currentPhotoImageView)
            pinchGestureRecognizer.view?.transform = (pinchGestureRecognizer.view?.transform)!.scaledBy(x: pinchGestureRecognizer.scale, y: pinchGestureRecognizer.scale)
            pinchGestureRecognizer.scale = 1.0
        } else if pinchGestureRecognizer.state == .ended {
            self.currentPhotoImageView.transform = CGAffineTransform.identity
        }
        
    }
}
