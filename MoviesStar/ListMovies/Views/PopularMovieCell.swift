import UIKit
import Kingfisher

class PopularMovieCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var movieTitle: UILabel?
    @IBOutlet weak var favoriteIcon: UIImageView!
    
    func setup(movie: Movie) {
        self.movieTitle?.text = movie.title
        self.movieTitle?.font = UIFont(name: "Avenir", size: 16)
        if let posterPath = movie.posterPath{
            let imageURL = APIClient.imageBaseURL + posterPath
            self.loadImage(imageURL: imageURL)
        }
        
        self.setFavorite(movie: movie)
    }
    
    private func loadImage(imageURL: String) {
        self.imageView?.kf.indicatorType = .activity
        self.imageView?.kf.setImage(with: URL(string: imageURL))
    }
    
    private func setFavorite(movie: Movie) {
        let movieController = MovieController()
        if movieController.isFavoriteMovie(movie: movie){
            favoriteIcon.image = Assets.favoriteFull.image
        }else{
            favoriteIcon.image = Assets.favoriteGray.image
        }
    }
}
