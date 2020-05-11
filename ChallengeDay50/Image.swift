//
//  Image.swift
//  ChallengeDay50
//
//  Created by Ceboolion on 10/05/2020.
//  Copyright © 2020 Ceboolion. All rights reserved.
//

import UIKit

class Image: NSObject, Codable {
    var imageName: String
    var image: String
    
    init(imageName: String, image: String) {
        self.imageName = imageName
        self.image = image
    }
}
