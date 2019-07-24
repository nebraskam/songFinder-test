//
//  Dowloader.swift
//  songFinderApp
//
//  Created by Nebraska Melendez on 7/24/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation

class Downloader{
    
    class func downloadFileFromURL(url:URL,completion:@escaping(URL?) -> Void){
        
        
        let downloadTask : URLSessionDownloadTask = URLSession.shared.downloadTask(with: url) { (url, response, error) in
            
            completion(url)
        }
        
        downloadTask.resume()
    }
}
