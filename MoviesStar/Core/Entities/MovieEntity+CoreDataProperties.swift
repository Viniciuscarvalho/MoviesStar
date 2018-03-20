import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var overview: String
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String
    @NSManaged public var title: String
    @NSManaged public var releaseYear: String
    @NSManaged public var genres: NSSet

}

// MARK: Generated accessors for genres
extension MovieEntity {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: GenreEntity)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: GenreEntity)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}
