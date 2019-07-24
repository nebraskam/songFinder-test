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

    let reuseIdentifier = "SongCell"
    var filteredTracks = [TrackModel]()
    var searchTimer: Timer?
    var tracks: [TrackModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        self.setupView()
        self.setupSearchBar()
        self.setupViewCell()
        //Coloco valores de inicio//
        self.getMusic(searchText: "Adele", limit: 20)
        
        
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
        navigationController?.navigationBar.backgroundColor = UIColor.lightGray
        
        
    }
    
    private func setupSearchBar(){
        
        // set search bar //
        
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            //textfield.textColor = // Set text color
            if let backgroundview = textfield.subviews.first {
                
                // Background color
                backgroundview.backgroundColor = .white
                // Rounded corner
                backgroundview.layer.cornerRadius = 10
                backgroundview.clipsToBounds = true
                
            }
        }
        
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.hidesBottomBarWhenPushed = true
            definesPresentationContext = true
        
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = true

    }
    
    private func setupViewCell(){
        
        let nibCell = UINib(nibName: reuseIdentifier, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: reuseIdentifier)
        
    }
    
    //MARK: Funcs
    
    private func getMusic(searchText:String,limit:Int){
        
        GlobalServices.shared.musicServices.getMusic(with: searchText, limit: limit) { (response) in
            
            switch response{
            case .success(data: let pagedListTracks):
                
                self.filteredTracks = pagedListTracks.results
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                
            case .error(error: let error):
                print(error.localizedDescription)
            }
        }
    }

    private func filterTracks(for searchText: String) {
    }
 
}

//MARK: Implement TableView

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
        
        //Present song detail
        let album = self.filteredTracks[indexPath.row]
        let songDetailController = SongDetailViewController.createController(album: album)
        self.navigationController?.pushViewController(songDetailController, animated: true)
        
    }
    
}

//MARK: Search Updating

extension SongFinderViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let timer = self.searchTimer{
            timer.invalidate()
        }
        
        guard let text = searchController.searchBar.text else{
            return
        }
        
        if text.isEmpty{
            return
        }
        
        self.searchTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: false) { (timer) in
            
            print("search text")
            self.getMusic(searchText: text, limit: 20)
            timer.invalidate()
            
        }
    }
    
}
