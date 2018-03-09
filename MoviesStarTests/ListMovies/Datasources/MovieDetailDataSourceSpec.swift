//
//  MovieDetailDataSourceSpec.swift
//  ios-trainning-projectTests
//
//  Created by Jose Freitas on 20/02/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import ios_trainning_project

class MovieDetailDataSourceSpec: QuickSpec {
    
    override func spec() {
        describe("MovieDetailDataSource"){
            
            context("when genre names are requested") {
                let genre = Genre(id: 12, name: "Comedy")
                let movie = Movie(id: 1,
                                  title: "",
                                  posterPath: "",
                                  releaseDate: "",
                                  genreIds: [12, 12],
                                  overview: "")
                let sut = MovieDetailDataSource(genres: [genre, genre])
                sut.movie = movie
                
                it("should return names for movie genre ids") {
                    expect(sut.genreNameList().count).to(equal(2))
                }
                
                it("should return empty array for nil movie") {
                    sut.movie = nil
                    expect(sut.genreNameList().count).to(equal(0))
                }
            }
        }
    }
}
