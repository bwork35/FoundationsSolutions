//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by Bryan Workman on 3/29/22.
//

import UIKit

class MovieListTableViewController: UITableViewController {

    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    //MARK: - Properties
    var movies: [Movie] = []
    
    //MARK: - Helper Methods
    func fetchMoviesWith(searchTerm: String) {
        MovieController.fetchMoviesWith(searchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movies = movies
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }

        let movie = movies[indexPath.row]
        
        cell.movie = movie

        return cell
    }

} //End of class

extension MovieListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        fetchMoviesWith(searchTerm: searchTerm)
    }
} //End of class
