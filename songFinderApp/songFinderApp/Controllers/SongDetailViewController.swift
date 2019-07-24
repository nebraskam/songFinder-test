//
//  SongDetailViewController.swift
//  songFinderApp
//
//  Created by Nebraska Melendez on 7/23/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import UIKit
import SDWebImage
import AVFoundation

class SongDetailViewController: UIViewController {

    //MARK: UIVars
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var previewSongImage: UIImageView!
    @IBOutlet weak var previewSongName: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    
    //MARK: Vars
    var album: TrackModel!
    var songs:[TrackModel] = []
    var selectedSong: TrackModel?
    let reuseIdentifier = "SongDetailCell"
    var player: AVAudioPlayer?
    
    static func createController(album:TrackModel) -> SongDetailViewController{
        
        let storyboard = UIStoryboard(name: "SongDetail", bundle: nil)
        let songDetailController = storyboard.instantiateInitialViewController()! as! SongDetailViewController
        songDetailController.album = album
        return songDetailController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        self.setupView()
        self.setupViewCell()
        self.getSongs()
    }
    

    private func setupView(){
        
        //Add Header view//
        
        let headerView = SongDetailHeaderView.create()
        headerView.songAlbum.text = album.collectionName
        headerView.songName.text = album.trackName
        headerView.songArtist.text = album.artistName
        
        if let urlString = album.artworkUrl100{
            headerView.songImage.sd_setImage(with: URL(string:urlString))
        }
        
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150)
        tableView.tableHeaderView = headerView
        
        // Delete extra cells//
        tableView.tableFooterView = UIView()
        
        //Confg Navigation
        navigationItem.title = album.collectionName
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = ""
        self.navigationItem.backBarButtonItem = backButtonItem
        
        //Footer image placeholder //
        
        let image = UIImage(named: "music")
        self.previewSongImage.image = image
        
    }
    
    private func setupViewCell(){
        
        let nibCell = UINib(nibName: reuseIdentifier, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: reuseIdentifier)
      
        
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        
        // pause //
        if let player = player, player.isPlaying{
//            playButton.setTitle("Play", for: .normal)
            let image = UIImage(named: "play")
            playButton.setImage(image, for: .normal)
            player.pause()
            return
        }
        
        // play //
        if let player = player, !player.isPlaying{
            let image = UIImage(named: "pause")
            playButton.setImage(image, for: .normal)
            player.play()
            return
        }
        
        // init play //
        guard let song = selectedSong else{
            return
        }
        
        self.previewSongName.text = "Loading..."
        // get preview url //
        song.getTrackPreview {(url) in
            
            DispatchQueue.main.async {
                self.previewSongName.text = song.trackName
            }
            
            guard let url = url else{
                return
            }
            
            // set player and play sounds //
            do {
                self.player = try AVAudioPlayer(contentsOf: url)
                self.player?.prepareToPlay()
                self.player?.volume = 1.0
                self.player?.play()
                
                DispatchQueue.main.async {
                    let image = UIImage(named: "pause")
                    self.playButton.setImage(image, for: .normal)
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
            } catch {
                print("AVAudioPlayer init failed")
            }
        }
    }
    
    
    private func updateSelectedSong(with song: TrackModel){
        
        selectedSong = song
        player = nil
        
        previewSongName.text = song.trackName
        if let urlString = song.artworkUrl60{
            previewSongImage.sd_setImage(with: URL(string:urlString))
        }
        playButton.setTitle("Play", for: .normal)
        
        // animate reload //
        previewSongName.alpha = 0
        playButton.alpha = 0
        previewSongImage.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            self.previewSongName.alpha = 1
            self.playButton.alpha = 1
            self.previewSongImage.alpha = 1
            
        }
    }
    
    
    private func getSongs(){
        
        guard let id = album.collectionId else{
            return
        }
        
        GlobalServices.shared.songServices.getSongs(collectionId: id , limit: 20) { (response) in
            
            switch response{
                
            case .success(data: let paginatedSongs):
                
                self.songs = paginatedSongs.results
                
                // element 0 is the album of the tracks //
                self.songs.remove(at: 0)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .error(error: let error):
                print(error.localizedDescription)
            }
        }
    }

}

extension SongDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return songs.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! SongDetailCellViewController

        let song = songs[indexPath.row]
        cell.songName.text = song.trackName
            
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let song = songs[indexPath.row]
        self.updateSelectedSong(with: song)
    }
  
}
