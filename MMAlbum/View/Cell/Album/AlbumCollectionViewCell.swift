//
//  AlbumCollectionViewCell.swift
//  MMAlbum
//
//  Created by David Munoz on 4/2/19.
//  Copyright © 2019 David Munoz. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var backgroundCustomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundCustomView.layer.masksToBounds = true
        self.backgroundCustomView.layer.cornerRadius = 6

    }

}
