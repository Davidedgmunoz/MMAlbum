//
//  PhotoCollectionViewCell.swift
//  MMAlbum
//
//  Created by David Munoz on 4/2/19.
//  Copyright © 2019 David Munoz. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true

    }

}
