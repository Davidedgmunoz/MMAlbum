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
    
    var oldCellFrame : CGRect!
    let reusableCell = "albumCell"
    let reusablePhotoCell = "photoCell"
    var currentPage = 1
    
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

    
    func getAlbums() {
        apiService.getAlbums(forPage: currentPage) { (albums) in
            DispatchQueue.main.async {

                
                if self.albums.count > 0 {
                    CATransaction.begin()
                    CATransaction.setDisableActions(true)
                    
                    self.albums = self.albums + albums
                    let indexPaths = Array(((self.currentPage-1)*20)-1...(((self.currentPage-1)*20)+18)).map { IndexPath(item: $0, section: 0) }

                    self.albumCollectionView?.insertItems(at: indexPaths)
                    
                    CATransaction.commit()
                    
                    
                    self.albumCollectionView.scrollToItem(at: indexPaths.first!, at: .bottom , animated: true)
                    
                }else{
                    self.albums.append(contentsOf:albums)
                    self.albumCollectionView.reloadData()
                    self.getPhotos(forAlbum: albums.first?.id ?? 1 )
                    self.albumaAcitivtyIndicator.stopAnimating()
                }
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

