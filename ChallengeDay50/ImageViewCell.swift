//
//  ImageViewCell.swift
//  ChallengeDay50
//
//  Created by Ceboolion on 09/05/2020.
//  Copyright © 2020 Ceboolion. All rights reserved.
//

import Foundation
import UIKit

class ImageViewCell: UITableViewCell {
    
    var newImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = image.frame.height / 2
        return image
    }()
    var name = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(){
        addSubview(newImage)
        newImage.translatesAutoresizingMaskIntoConstraints = false
        newImage.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        newImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        newImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        newImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        newImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leadingAnchor.constraint(equalTo: newImage.trailingAnchor, constant: 15).isActive = true
        name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 15).isActive = true
        name.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
