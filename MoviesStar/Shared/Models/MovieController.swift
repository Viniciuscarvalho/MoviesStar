import Foundation
import CoreData

class MovieController{
    
    func getMovieYear(movie: Movie) -> String {
        guard let date = Date.from(dateString: movie.releaseDate) else {
            return ""
        }
        return "\(date.year)"
    }
    
    func save(movie: Movie) {
        MovieCoreDataManager.save(movie: movie)
    }
    
    
    func isFavoriteMovie(movie: Movie) -> Bool {
        if let _ = self.fetchBy(id: movie.id) {
            return true
        }
        return false
    }
    
    func remove(id: Int) {
        MovieCoreDataManager.remove(id: id)
    }
    
    func fetch(byGenres genreIds: [Int]) -> [Movie] {
        
        let moviesEntity = MovieCoreDataManager.fetch(byGenres: genreIds)
        
        return convert(moviesEntity: moviesEntity)
    }
    
    func fetch(byGenreNames genresName: [String]) -> [Movie] {
        
        let moviesEntity = MovieCoreDataManager.fetch(byGenresName: genresName)
        
        return convert(moviesEntity: moviesEntity)
    }
    
    func fetch(byYear year: String) -> [Movie]{
        
        let moviesEntity = MovieCoreDataManager.fetch(byYear: year)
        
        return convert(moviesEntity: moviesEntity)
    }
    
    func fetch(byGenre genre: Genre, andYear year: String) -> [Movie] {
        
        let moviesEntity = MovieCoreDataManager.fetch(byGenreId: Int(genre.id), andYear: year)

        return convert(moviesEntity: moviesEntity)
    }
    
    func fetch(byGenreName name: String, andYear year: String) -> [Movie] {
    
        let moviesEntity = MovieCoreDataManager.fetch(byGenreName: name, andYear: year)
    
        return convert(moviesEntity: moviesEntity)
    }
    
    func fetchWithoutDuplicateYears() -> [String] {
        let moviesEntity = MovieCoreDataManager.fetchAll()
        var items: [String] = []
        _ = moviesEntity.map { items.append($0.releaseYear) }
        let years = Array(Set(items))
        return years.sorted()
    }

    fileprivate func convert(moviesEntity: [MovieEntity]) -> [Movie] {
  
        var movies: [Movie] = []
        
        for movieEntity in moviesEntity {
            movies.append(self.convert(movieEntity: movieEntity))
        }
        return movies
    }
    
    fileprivate func convert(movieEntity: MovieEntity) -> Movie {
        
        var genreIds:[Int] = []
        let genreCoreDataManager = GenreCoreDataManager()
        let genres = genreCoreDataManager.fetch(byMovie: movieEntity)
        
        for genre in genres {
            genreIds.append(Int(genre.id))
        }
        
        return Movie(id: Int(movieEntity.id),
                     title: movieEntity.title,
                     posterPath: movieEntity.posterPath,
                     releaseDate: movieEntity.releaseDate,
                     genreIds: genreIds,
                     overview: movieEntity.overview)
    }
}

extension MovieController: ModelProtocol {
    
    typealias Model = Movie
    
    func fetchAll() -> [Movie]{
        
        let fetchedMovies = MovieCoreDataManager.fetchAll()
        
        return convert(moviesEntity: fetchedMovies)
    }
    
    
    func add(data: Data) -> [Movie]? {
        do {
            let moviesList = try JSONDecoder().decode(MovieList.self, from: data)
            return moviesList.movies
        }catch{
            return nil
        }
    }
    
    func fetchBy(ids: [Int]) -> [Movie] {
        
        return []
    }
    
    func fetchBy(id: Int) -> Movie? {
        if let fetchedMovie = MovieCoreDataManager.fetch(byId: id) {
            return self.convert(movieEntity: fetchedMovie)
        }
        return nil
    }
    
    
}

