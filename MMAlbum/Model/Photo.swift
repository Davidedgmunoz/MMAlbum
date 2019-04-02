//
//  Photo.swift
//  MMAlbum
//
//  Created by David Munoz on 4/2/19.
//  Copyright © 2019 David Munoz. All rights reserved.
//

import UIKit

class Photo: Codable {
    var albumId : Int!
    var id : Int!
    var title : String!
    var url : String!
    var thumbnailUrl : String!
}
