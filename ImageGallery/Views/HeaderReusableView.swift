//
//  HeaderReusableView.swift
//  ImageGallery
//
//  Created by Shubham Choudhary on 24/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import UIKit
import SDWebImage

class HeaderReusableView: UICollectionReusableView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var userImageURL: String? {
        didSet {
            // Download image from image URL
            if let url = userImageURL {
                imageView.sd_setShowActivityIndicatorView(true)
                imageView.sd_setIndicatorStyle(.gray)
                imageView.sd_setImage(with:  URL(string: url), placeholderImage: #imageLiteral(resourceName: "placeholder"), options: .progressiveDownload, completed: nil)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = ""
    }
}
