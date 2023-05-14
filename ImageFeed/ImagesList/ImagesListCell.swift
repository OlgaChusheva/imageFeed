//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Ольга Чушева on 01.05.2023.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentificator = "ImagesListCell"
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dataLabel: UILabel!
    
    

    
}
