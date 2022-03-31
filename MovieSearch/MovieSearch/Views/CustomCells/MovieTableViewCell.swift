//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Bryan Workman on 3/29/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    //MARK: - Properties
    var movie: Movie? {
        didSet{
            updateViews()
        }
    }
    
    //MARK: - Helper Methods
    func updateViews(){
        guard let movie = movie else {return}
        movieTitleLabel.text = movie.title
        movieRatingLabel.text = "Rating: \(movie.rating)"
        movieOverviewLabel.text = movie.overview
        
        MovieController.fetchImageFor(movie: movie) { (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            case .failure(let error):
                self.movieImageView.image = UIImage(systemName: "photo.on.rectangle")
                print(error.localizedDescription)
            }
        }
    }
    
    override func prepareForReuse() {
        movieImageView.image = nil
    }

} //End of class
