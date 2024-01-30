//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Ольга Чушева on 01.05.2023.
//

import UIKit
import Kingfisher

protocol ImagesListCellDelegate: AnyObject {
    func imagesListCellDidTapLike(_ cell: ImagesListCell)
}

final class ImagesListCell: UITableViewCell {
    
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
 
        
    @IBOutlet weak var dataLabel: UILabel!
    
    weak var delegate: ImagesListCellDelegate?
    
    static let reuseIdentificator = "ImagesListCell"
    
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        delegate?.imagesListCellDidTapLike(self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Отменяем загрузку, чтобы избежать багов при переиспользовании ячеек
        cellImage.kf.cancelDownloadTask()
    }
    
    func setIsLiked(isLiked: Bool) {
        let isLiked = isLiked ? UIImage(named: "like_button_on") : UIImage(named: "like_button_off")
        likeButton.setImage(isLiked, for: .normal)
    }
    
    

    
}
