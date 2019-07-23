//
//  GlobalServices.swift
//  songFinderApp
//
//  Created by Nebraska Melendez on 7/23/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation

class GlobalServices{
    
    //MARK: - Attr
    private let apiSettings: ApiSettings
    public let musicServices: MusicServices
    
    static let shared:GlobalServices = GlobalServices()
    private init(){
        self.apiSettings = ApiSettings.init(baseUrl: "https://itunes.apple.com")
        self.musicServices = MusicServices(settings:apiSettings,route:"search")
        
    }
}
