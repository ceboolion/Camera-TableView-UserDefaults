//
//  DetailImageController.swift
//  ChallengeDay50
//
//  Created by Roman Cebula on 11/05/2020.
//  Copyright © 2020 Ceboolion. All rights reserved.
//

import Foundation
import UIKit

class DeatailImageController: UIViewController {
  
    var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  func configureView(){
    view.addSubview(image)
    image.translatesAutoresizingMaskIntoConstraints = false
    image.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
    image.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    image.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    image.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
}
