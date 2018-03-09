import Foundation

struct Movie:Codable{
    
    var id: Int
    var title: String
    var posterPath : String?
    var releaseDate: String
    var genreIds: [Int]
    var overview: String
    
    enum CodingKeys:String, CodingKey{
        
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case overview
    }
}

struct MovieList:Codable{
    var movies: [Movie]
    enum CodingKeys:String, CodingKey{
        case movies = "results"
    }
}
