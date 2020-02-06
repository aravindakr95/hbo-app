//
//  SearchMoviesController.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 2/5/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SafariServices

class SearchMoviesController: UITableViewController {
    public var searchResults = [JSON]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    public let requestFetcher = RequestFetcher()
    public var previousRun = Date()
    public let minInterval = 0.05
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movies"
        tableView.tableFooterView = UIView()
        setupTableViewBackgroundView()
        setupSearchBar()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath) as! CustomTableViewCell
        cell.lblTitle.text = searchResults[indexPath.row]["Title"].stringValue
        cell.lblYear.text = searchResults[indexPath.row]["Year"].stringValue
        
        let url = searchResults[indexPath.row]["Poster"].stringValue
        //        cell.hboImageView.showLoading() // TODO: EXC_BAD_ACCESS Fix
        
        requestFetcher.fetchImage(url: url, completionHandler: { image, _ in
            cell.hboImageView.image = image
//            cell.hboImageView.hideLoading()
        })
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let imdbId = searchResults[indexPath.row]["imdbID"].stringValue
        guard let url = URL.init(string: "https://www.imdb.com/title/\(imdbId)")
            else { return }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func setupTableViewBackgroundView() {
        let backgroundViewLabel = UILabel(frame: .zero)
        backgroundViewLabel.textColor = .darkGray
        backgroundViewLabel.numberOfLines = 0
        backgroundViewLabel.text = "Oops!, No movies to show."
        backgroundViewLabel.textAlignment = NSTextAlignment.center
        backgroundViewLabel.font.withSize(20)
        tableView.backgroundView = backgroundViewLabel
    }
    
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
}

