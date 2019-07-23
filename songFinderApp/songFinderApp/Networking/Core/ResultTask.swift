//
//  ResultTask.swift
//  songFinderApp
//
//  Created by Nebraska Melendez on 7/23/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation

enum ResultTask<T>{
    
    case success(data:T)
    case error(error:Error)
}
