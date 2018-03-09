//
//  DataSourceSearchableStub.swift
//  ios-trainning-projectTests
//
//  Created by m.marques.goncalves on 26/02/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//

import Foundation
@testable import ios_trainning_project

class DataSourceSearchableStub: DataSourceSearchable {
    var isSearching: Bool = false
    
    var filteredMovies: [Movie] = []
    
    func filter(withText text: String) {
        let movie = Movie(id: 0, title: text, posterPath: "", releaseDate: "", genreIds: [1], overview: "")
        filteredMovies.append(movie)
    }
}
