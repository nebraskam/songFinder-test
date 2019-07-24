//
//  SongDetailViewController.swift
//  songFinderApp
//
//  Created by Nebraska Melendez on 7/23/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import UIKit

class SongDetailViewController: UIViewController {

    //MARK: UIVars
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    //MARK: Vars
    
    let reuseIdentifier = "SongDetailHeaderCell"
    let reuseIdentifierSong = "SongDetailCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        self.setupView()
        self.setupViewCell()
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }

    private func setupView(){
        
        //Confg TableView
        view.addSubview(tableView)
        
        // Eliminar extra cells//
        tableView.tableFooterView = UIView()
        
        //Confg Navigation
        navigationItem.title = ""
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = ""
        self.navigationItem.backBarButtonItem = backButtonItem
        
    }
    
    private func setupViewCell(){
        
        let nibCell = UINib(nibName: reuseIdentifier, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: reuseIdentifier)
        tableView.register(nibCell, forCellReuseIdentifier: reuseIdentifierSong )
        
    }

}

extension SongDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! SongDetailHeaderCellViewController
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        return 150
    }
    
    
    
    
}
