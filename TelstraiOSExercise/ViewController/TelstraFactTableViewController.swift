//
//  TelstraFactTableViewController.swift
//  TelstraiOSExercise
//
//  Created by Digvijay.digvijay on 6/21/20.
//  Copyright © 2020 Digvijay.digvijay. All rights reserved.
//

import UIKit

import UIKit
//MARK:  TABLE VIEW CONTROLLER TO DISPLAY IMAGES
class TelstraFactTableViewController: UIViewController {

    var viewModel: TelstraFactTableViewModel!
    var dataSet : [TelstraFactData] = []
    var imageDownloader : ImageDownloaderManager?
    var tableView = UITableView()
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TelstraFactTableViewModel.init(responder: self)
        view.addSubview(tableView)
        addConstraintsToTable()
        addPullToRefresh()
        tableView.register(TelstraFactsTableViewCell.self, forCellReuseIdentifier: CELL_ID)
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        imageDownloader = ImageDownloaderManager()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
            viewModel.loadTelstraData()
       }
    
    //MARK:  - ADD PULL TO REFRESH
    func addPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: PULL_TO_REFRESH)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    
    // MARK:  - ACTION FOR PULL TO REFRESH
    @objc func refresh(_ sender: AnyObject) {
       viewModel.loadTelstraData()
    }
    
    
    //MARK: - TABLEVIEW AUTOLAYOUT CONSTRNT
    func addConstraintsToTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }


}


//MARK:  - EXTENSION FOR TELSTRA TABLE VIEW CONTROLLER
extension TelstraFactTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - TABLE VIEW DATASOURCE
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returns the Number of Data Set with valid titles.
        return dataSet.count
    }
    
    // Return cell to be display at any indexpath 
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Returns the Telstra Cell With Proper Data
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! TelstraFactsTableViewCell
        let currentItem = dataSet[indexPath.row]
        cell.setData(currentItem)
        return cell
    }
    
    // MARK:  - TABLE VIEW DELEGATE
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    /// Downloads the images which are being shown on the screen at the moment.
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! TelstraFactsTableViewCell
        let currentItem = dataSet[indexPath.row]
        if let imageUrl = currentItem.imageUrl {
            DispatchQueue.global(qos: .default).async {
                self.imageDownloader?.checkImage(path: imageUrl, completion: { (image) in
                    DispatchQueue.main.async {
                        if tableView.cellForRow(at: indexPath) != nil {
                            cell.cellImage.image = image
                        }
                    }
                })
            }
        }
    }
}

//MARK:  - EXTENSION FOR RESPONDER
extension TelstraFactTableViewController: TelstraViewResponder {
     func updateTelstraFactList(_ data: [TelstraFactData]) {
        self.dataSet = data
        DispatchQueue.main.async {
             self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func updateTelstraTitle(_ title: String) {
        DispatchQueue.main.async {
            self.title = title
        }
    }
}




