//
//  SongDetailHeaderCellVC.swift
//  songFinderApp
//
//  Created by Nebraska Melendez on 7/23/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation
import UIKit

class SongDetailHeaderCellViewController : UITableViewCell {
    
    //MARK: UIVars
    
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songAlbum: UILabel!
    @IBOutlet weak var songArtist: UILabel!
    @IBOutlet weak var songName: UILabel!
    
    override func awakeFromNib() {
    super.awakeFromNib()
    
    }
    
}
