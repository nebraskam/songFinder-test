//
//  SongFinderViewController.swift
//  songFinderApp
//
//  Created by Nebraska Melendez on 7/22/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import UIKit

class SongFinderViewController: UIViewController {

    //MARK: UIVars
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: Vars
   // var songs = ["Hello", "Sunshine", "Jump"]
    let reuseIdentifier = "SongCell"
    var filteredTracks = [TrackModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        self.setupView()
        self.setupViewCell()
        self.getMusic()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: Setups
    
    private func setupView(){
        
        //Confg TableView
        view.addSubview(tableView)
        
        // Eliminar extra cells//
        tableView.tableFooterView = UIView()
        
        //Confg Navigation
        navigationItem.title = "Buscador de canciones"
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = ""
        self.navigationItem.backBarButtonItem = backButtonItem
        
        //Confg Search Bar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor.white
        
    }
    
    private func setupViewCell(){
        
        let nibCell = UINib(nibName: reuseIdentifier, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: reuseIdentifier)
        
    }
    
    //MARK: Funcs
    
    private func getMusic(){
        
        let searchText = searchController.searchBar.text
        GlobalServices.shared.musicServices.getMusic(with: "Hello", limit: 20) { (response) in
            
            switch response{
            case .success(data: let pagedListTracks):
                
                for track in pagedListTracks.results{
                    self.filteredTracks = pagedListTracks.results
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    print(track.trackName)
                }
                
            case .error(error: let error):
                print(error.localizedDescription)
            }
        }
    }

//    private func filterTracks(for searchText: String) {
//        filteredTracks = songs.filter { footballer in
//            return songs.name.lowercased().contains(searchText.lowercased())
//        }
//        tableView.reloadData()
//    }
 
}

extension SongFinderViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return filteredTracks.count
  
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! SongCellViewController
        var track = filteredTracks[indexPath.row]
        
        track = filteredTracks[indexPath.row]
        cell.artistName.text = track.artistName
        cell.songName.text = track.trackName
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


extension SongFinderViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
//        filterSongs(for: searchController.searchBar.text ?? "")
    }
}
