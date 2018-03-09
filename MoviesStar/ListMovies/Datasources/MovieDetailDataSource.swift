import Foundation

class MovieDetailDataSource {
    
    fileprivate var genres: [Genre]
    var movie: Movie?
    
    init(genres: [Genre]){
        self.genres = genres
    }
    
    func genreNameList() -> [String] {
        guard let movie = movie else {return []}
        let genreController = GenreController()
        
        return genreController.genreNames(genres: self.genres, for: movie.genreIds)
    }
}
