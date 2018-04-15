import Foundation
import CoreData

class MovieCoreDataManager {
    
    static func save(movie: Movie) {
        let managedContext = CoreDataHelper.defaultContext()
        guard let entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: managedContext) else {
            return
        }
        
        let movieEntity = MovieEntity(entity: entity, insertInto: managedContext)
        movieEntity.id = Int32(movie.id)
        movieEntity.title = movie.title
        movieEntity.overview = movie.overview
        movieEntity.releaseDate = movie.releaseDate
        movieEntity.posterPath = movie.posterPath
        movieEntity.releaseYear = ""
        
        if let date = Date.from(dateString: movie.releaseDate) {
            movieEntity.releaseYear = "\(date.year)"
        }
        
        let genreCoreDataManager = GenreCoreDataManager()

        if let genres = genreCoreDataManager.fetch(byIds: movie.genreIds) {
            for genre in genres {
                genre.addToMovies(movieEntity)
            }
        }
        CoreDataHelper.save()
    }
    
    static func remove(id: Int) {
        if let movie = MovieCoreDataManager.fetch(byId: id) {
            CoreDataHelper.defaultContext().delete(movie)
            CoreDataHelper.save()
        }
    }
    
    static private func fetch(predicate: NSPredicate?) -> [MovieEntity] {
        
        let fetchRequest: NSFetchRequest = MovieEntity.fetchRequest()
        let sortByYear = NSSortDescriptor(key: "releaseYear", ascending: false)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sortByYear]
        
        do {
            let movies: [MovieEntity] = try CoreDataHelper.defaultContext().fetch(fetchRequest) as [MovieEntity]
            return movies
        } catch {
            print("Could not fetch \(error.localizedDescription)")
        }
        return []
    }
    
    static func fetchAll() -> [MovieEntity] {
        return fetch(predicate: nil)
    }
    
    
    static func fetch(byId id: Int) -> MovieEntity? {
        
        let predicate = NSPredicate(format: "id = %d", id)
        
        return self.fetch(predicate: predicate).first
    }
    
    
    static func fetch(byGenres genreIds: [Int]) -> [MovieEntity] {
        
        let genreCoreDataManager = GenreCoreDataManager()
        
        guard let genres = genreCoreDataManager.fetch(byIds: genreIds) else { return [] }
        
        let predicate = NSPredicate(format: "ANY genres IN %@", genres)
        
        return self.fetch(predicate: predicate)
    }
    
    static func fetch(byGenresName genresName: [String]) -> [MovieEntity] {
        
        let genreCoreDataManager = GenreCoreDataManager()
        
        guard let genres = genreCoreDataManager.fetch(byNames: genresName) else { return [] }
        
        let predicate = NSPredicate(format: "ANY genres IN %@", genres)
        
        return self.fetch(predicate: predicate)
    }
    
    
    static func fetch(byYear year:String) -> [MovieEntity] {
        
        let predicate = NSPredicate(format: "releaseYear == %@", year)
        
        return self.fetch(predicate: predicate)
    }
    
    static func fetch(byGenreId genreId: Int, andYear year: String) -> [MovieEntity] {
        
        let genreCoreDataManager = GenreCoreDataManager()
        guard let genre = genreCoreDataManager.fetch(byID: genreId) else { return [] }
        
        let genreIdPredicate = NSPredicate(format: "ANY genres IN %@", [genre])
        let yearPredicate = NSPredicate(format: "releaseYear == %@", year)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [genreIdPredicate,yearPredicate])
        
        return self.fetch(predicate: predicate)
    }
    
    static func fetch(byGenreName name: String, andYear year: String) -> [MovieEntity] {
        
        let genreCoreDataManager = GenreCoreDataManager()
        guard let genre = genreCoreDataManager.fetch(byName: name) else { return [] }
        
        let genrePredicate = NSPredicate(format: "ANY genres IN %@", [genre])
        let yearPredicate = NSPredicate(format: "releaseYear == %@", year)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [genrePredicate,yearPredicate])
        
        return self.fetch(predicate: predicate)
    }
}
