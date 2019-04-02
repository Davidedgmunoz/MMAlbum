//
//  ViewController.swift
//  MMAlbum
//
//  Created by David Munoz on 4/2/19.
//  Copyright © 2019 David Munoz. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var albumCollectionView: UICollectionView!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var photosActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var albumaAcitivtyIndicator: UIActivityIndicatorView!
    
    
    let reusableCell = "albumCell"
    let reusablePhotoCell = "photoCell"
    
    var albums = [Album]()
    var photos = [Photo]()
    
    fileprivate let apiService = AlbumAPIService.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        photosCollectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reusablePhotoCell)
        albumCollectionView.register(UINib(nibName: "AlbumCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reusableCell)
        photosActivityIndicator.startAnimating();
        albumaAcitivtyIndicator.startAnimating()
        getAlbums()
    }

    
    fileprivate func getAlbums() {
        apiService.getAlbums { (albums) in
            self.albums = albums
            DispatchQueue.main.async {
                self.albumCollectionView.reloadData()
                self.albumaAcitivtyIndicator.stopAnimating()
            }
        }
    }
    
    func getPhotos(forAlbum albumId : Int){
        apiService.getPhotosFor(Album: albumId) { (photos) in
            self.photos = photos
            self.photosCollectionView.reloadData()
            self.photosActivityIndicator.stopAnimating()
        }
    }

}

