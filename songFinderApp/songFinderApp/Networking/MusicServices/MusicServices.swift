//
//  MusicServices.swift
//  songFinderApp
//
//  Created by Nebraska Melendez on 7/23/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation

class MusicServices : ApiRest{
    
    let decoder = JSONDecoder()
    
    
    func getMusic(with searchText:String,
                  limit: Int,
                  completion:@escaping(ResultTask<PagedList<TrackModel>>) -> Void){
        
        let endpoint =  self.serviceUrl.appending("term", value: searchText)
            .appending("mediaType", value: "music")
            .appending("limit", value: "\(limit)")
        
        
        let dataTask = URLSession.shared.dataTask(with: endpoint) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                // Handle Error
                completion(ResultTask.error(error: error))
                return
            }
            guard let response = response else {
                // Handle Empty Response
                return
            }
            guard let data = data else {
                // Handle Empty Data
                return
            }
            // Handle Decode Data into Model
            do{
                
                let tracks = try self.decoder.decode(PagedList<TrackModel>.self, from: data)
                completion(ResultTask.success(data: tracks))
                
            }catch(let error){
                completion(ResultTask.error(error: error))
                print("error mapping")
            }
        }
        
        dataTask.resume()
    }
}
