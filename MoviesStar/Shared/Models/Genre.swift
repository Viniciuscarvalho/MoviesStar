import Foundation

struct Genre: Codable{
    
    var id: Int
    var name: String
    
    enum CodingKeys:String, CodingKey{
        case id
        case name
    }
}

struct GenreList: Codable{
    var genres: [Genre]
    enum CodingKeys:String, CodingKey {
        case genres
    }
}
