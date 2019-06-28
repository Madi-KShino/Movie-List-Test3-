//
//  MovieListTableViewController.swift
//  TEST3(movieApi)
//
//  Created by Madison Kaori Shino on 6/28/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    //PROPERTIES
    var movies: [Movie] = []
    
    //OUTLETS
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // TABLE VIEW
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieDetailTableViewCell else { return UITableViewCell() }
 
        let movieShown = movies[indexPath.row]
        
        cell.nameLabel.text = movieShown.title
        cell.ratingLabel.text = "Rating: \(movieShown.rating)/10"
        cell.summaryLabel.text = movieShown.summary
        cell.dateLabel.text = movieShown.date
        MovieController.fetchMovieImages(forMovie: movieShown) { (image) in
            DispatchQueue.main.async {
                cell.movieImage.image = image
            }
        }
        return cell
    }
}

//SEARCH BAR FUNCTIONALITY
extension MovieListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text, searchText != "" else { return }
        MovieController.fetchMovie(searchEntered: searchText) { (moviesFromCompletion) in
            if let unwrappedMovies = moviesFromCompletion {
                self.movies = unwrappedMovies
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
