import UIKit
import Kingfisher
class FavoritesCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    func setup(movie: Movie){
        let movieController = MovieController()
        self.movieTitle.text = movie.title
        self.movieYear.text = movieController.getMovieYear(movie: movie)
        self.movieOverview.text = movie.overview
        
        if let posterPath = movie.posterPath{
            let imageURL = APIClient.imageBaseURL + posterPath
            self.movieImageView.kf.indicatorType = .activity
            self.movieImageView.kf.setImage(with: URL(string: imageURL))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        movieTitle.text = nil
        movieYear.text = nil
        movieOverview.text = nil
    }
    
    
    
}
