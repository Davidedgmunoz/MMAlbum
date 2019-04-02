//
//  AlbumAPIService.swift
//  MMAlbum
//
//  Created by David Munoz on 4/2/19.
//  Copyright © 2019 David Munoz. All rights reserved.
//

import UIKit
import Alamofire

class AlbumAPIService: NSObject {
    static let sharedInstance = AlbumAPIService()
    let decoder = JSONDecoder()
    
    override private init(){}
    
    
    
    func getAlbums(completionHandler : @escaping ([Album])->Void){
        AF.request("\(Constants.apiUrl)/albums").responseJSON { (response) in
            print("Result: \(response.result)")                         // response serialization result
            
            if let jsonData = response.data {
                let albums : [Album] = try! self.decoder.decode([Album].self, from: jsonData)
                completionHandler(albums)
                
            }
        }
    }
    
    func getPhotosFor(Album albumId : Int, completionHandler: @escaping ([Photo])->Void){
        AF.request("\(Constants.apiUrl)/photos?albumId=\(albumId)").responseJSON { (response) in
            print("Result: \(response.result)")                         // response serialization result
            
            if let jsonData = response.data {
                let photos : [Photo] = try! self.decoder.decode([Photo].self, from: jsonData)
                completionHandler(photos)
                
            }
        }
        
    }
}
