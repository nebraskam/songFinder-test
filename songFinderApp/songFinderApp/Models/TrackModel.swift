//
//  SongModel.swift
//  songFinderApp
//
//  Created by Nebraska Melendez on 7/22/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation

struct TrackModel: Codable {
    
    let artistName:String
    let collectionName:String
    let trackName: String
    let artistViewUrl:String?
    let collectionViewUrl:String?
    let artworkUrl30 : String?
    let artworkUrl60 : String?
    let artworkUrl100 : String?
      
}
