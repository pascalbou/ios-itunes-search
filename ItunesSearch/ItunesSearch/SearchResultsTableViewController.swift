//
//  SearchResultsTableViewController.swift
//  ItunesSearch
//
//  Created by krikaz on 3/13/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import UIKit

final class SearchResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var typesSegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let searchResultsController = SearchResultController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)

        cell.textLabel?.text = searchResultsController.searchResults[indexPath.row].title
        cell.detailTextLabel?.text = searchResultsController.searchResults[indexPath.row].creator
        
        return cell
    }

}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
                
        guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType!
        
        switch typesSegmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            resultType = .software
        }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
            if let error = error {
                NSLog("you failed like a big loser: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
