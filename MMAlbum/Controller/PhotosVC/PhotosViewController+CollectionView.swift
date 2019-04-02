//
//  PhotosViewController+CollectionView.swift
//  MMAlbum
//
//  Created by David Munoz on 4/2/19.
//  Copyright © 2019 David Munoz. All rights reserved.
//

import UIKit

extension PhotosViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == photosCollectionView {
            return photos.count
        }
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == photosCollectionView {
            return createPhotoCell(forCollectionView: collectionView, atIndexPath: indexPath, with: photos[indexPath.row])
        }
        
        return createAlbumCell(forCollectionView: collectionView, atIndexPath: indexPath, with: albums[indexPath.row])
       
    }
    
    fileprivate func createPhotoCell(forCollectionView  collectionView: UICollectionView,atIndexPath  indexPath: IndexPath, with item : Photo) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: reusablePhotoCell, for: indexPath) as! PhotoCollectionViewCell
        collectionCell.imageView.imageFromServerURL(urlString: item.thumbnailUrl)
        collectionCell.titleLabel.text = item.title
        collectionCell.layer.shouldRasterize = true;
        collectionCell.layer.rasterizationScale = UIScreen.main.scale
        

        return collectionCell
    }
    
    fileprivate func createAlbumCell(forCollectionView collectionView: UICollectionView,atIndexPath  indexPath: IndexPath, with item : Album) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCell, for: indexPath) as! AlbumCollectionViewCell
        collectionCell.albumTitleLabel.text = item.title
        collectionCell.backgroundCustomView.backgroundColor = UIColor.random()
        collectionCell.layer.shouldRasterize = true;
        collectionCell.layer.rasterizationScale = UIScreen.main.scale

        
        return collectionCell

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == photosCollectionView{
            let imageView = UIImageView()
            imageView.imageFromServerURL(urlString: photos[indexPath.row].url)

            let cellFrame = collectionView.convert(collectionView.cellForItem(at: indexPath)!.frame, to: self.view)
            imageView.frame = cellFrame
            imageView.backgroundColor = .black
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
            imageView.addGestureRecognizer(tap)
            
            self.view.addSubview(imageView)
            
            animation(imageview: imageView)
        }
        photosActivityIndicator.startAnimating()
        getPhotos(forAlbum : albums[indexPath.row].id)
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    
    func animation(imageview : UIImageView){
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            // HERE
            imageview.frame = self.view.frame
            imageview.layoutIfNeeded()
        })
    }

}
