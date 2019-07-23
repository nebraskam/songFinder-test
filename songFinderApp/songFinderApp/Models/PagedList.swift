//
//  PagedList.swift
//  songFinderApp
//
//  Created by Nebraska Melendez on 7/23/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation

struct PagedList<T:Codable>: Codable{
    
    let resultCount: Int
    let results:[T]
}
