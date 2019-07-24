//
//  SongDetailHeaderViewController.swift
//  songFinderApp
//
//  Created by Nebraska Melendez on 7/24/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation
import UIKit

class SongDetailHeaderViewController : UIView {

    //MARK: UIVars
    
    @IBOutlet weak var songImage: UIImageView!
    
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var songArtist: UILabel!
    @IBOutlet weak var songAlbum: UILabel!
    
    class func create() -> SongDetailHeaderViewController{
            return UINib(nibName: "SongDetailHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SongDetailHeaderViewController
    }

    override func awakeFromNib() {
            super.awakeFromNib()
    }

}
