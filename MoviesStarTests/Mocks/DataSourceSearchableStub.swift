import Foundation
@testable import MoviesStar

class DataSourceSearchableStub: DataSourceSearchable {
    var isSearching: Bool = false
    
    var filteredMovies: [Movie] = []
    
    func filter(withText text: String) {
        let movie = Movie(id: 0, title: text, posterPath: "", releaseDate: "", genreIds: [1], overview: "")
        filteredMovies.append(movie)
    }
}
