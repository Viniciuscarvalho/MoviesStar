//
//  GenreEntity+CoreDataProperties.swift
//  ios-trainning-project
//
//  Created by Rafael Aparecido de Freitas  on 27/02/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//
//

import Foundation
import CoreData


extension GenreEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenreEntity> {
        return NSFetchRequest<GenreEntity>(entityName: "GenreEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var movies: NSSet

}

// MARK: Generated accessors for movies
extension GenreEntity {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: MovieEntity)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: MovieEntity)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}
