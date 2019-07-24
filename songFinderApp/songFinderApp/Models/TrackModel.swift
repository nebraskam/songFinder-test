//
//  SongModel.swift
//  songFinderApp
//
//  Created by Nebraska Melendez on 7/22/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation

struct TrackModel: Codable {
    
    let artistName:String?
    let collectionName:String?
    let trackName: String?
    let collectionId: Int?
    let artistViewUrl:String?
    let collectionViewUrl:String?
    let artworkUrl30 : String?
    let artworkUrl60 : String?
    let artworkUrl100 : String?
    let previewUrl:String?
    let trackId: Int?
    
    //MARK: Funcs
    
    public func getTrackPreview(completion: @escaping (_ localURL: URL?) -> Void){
        
        guard let trackId = trackId else{
            completion(nil)
            return
        }
        
        if let cacheUrl = self.searchCacheFile(with: "\(trackId)"){
            completion(cacheUrl)
            return
        }
        
        self.downloadMultimedia(with: "\(trackId)") { (url) in
            completion(url)
        }
        
    }
    
    private func downloadMultimedia(with id: String,completion: @escaping (_ localURL: URL?) -> Void){
        
        guard let urlString = previewUrl else{
            completion(nil)
            return
        }
        
        guard let url = URL(string:urlString) else{
            completion(nil)
            return
        }
        
        
        var destinationUrl: URL = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first!
        let format = url.pathExtension
        
        destinationUrl.appendPathComponent("\(id).\(format)")
        
        Downloader.downloadFileFromURL(url: url) { (localUrl) in
            
            // cache file
            if let safeLocalUrl = localUrl{
                do{
                    try FileManager.default.copyItem(at: safeLocalUrl, to: destinationUrl)
                }catch{
                    completion(localUrl)
                }
            }
            
            completion(localUrl)
        }
        
    }
    
    private func searchCacheFile(with id: String) -> URL?{
        
        let destinationUrl: URL = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
            ).first!
        
        let documents =  try! FileManager.default.contentsOfDirectory(
            at: destinationUrl,
            includingPropertiesForKeys: nil
        )
        
        let index = documents.index { (url) -> Bool in
            return url.lastPathComponent.contains("\(id)")
        }
        
        if let index = index{
            return documents[index]
        }
        
        return nil
    }
      
}
