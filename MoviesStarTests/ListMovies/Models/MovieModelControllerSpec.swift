//
//  MovieModelControllerSpec.swift
//  ios-trainning-projectTests
//
//  Created by Rafael Aparecido de Freitas  on 09/02/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import ios_trainning_project

class MovieModelControllerSpec:QuickSpec{
    
    
    override func spec() {
        
        describe("MovieController") {
            
            context("When receive result", closure: {
                let data = LoadJson.loadListResultJson()
                let movieController = MovieController()
                let movies = movieController.add(data: data)
                
                it("should parse results not null", closure: {
                    expect(movies).toNot(beNil())
                })
                
                it("should parse results", closure: {
                    expect(movies?.count).to(beGreaterThan(0))
                })
                
                it("should return correct year", closure: {
                   let movieController = MovieController()
                    let year = movieController.getMovieYear(movie: movies!.first!)
                    expect(year).to(equal("2016"))
                })
                 
            })
            
            context("when receive empty result", closure: {
                let data = LoadJson.loadEmptyListResultJson()
                let movieController = MovieController()
                let movies = movieController.add(data: data)
                
                it("should parse empty results", closure: {
                    expect(movies?.count).to(equal(0))
                })
            })
            
            context("when receive empty release date", {
                let data = LoadJson.loadListResultJson()
                let movieController = MovieController()
                let movies = movieController.add(data: data)
                
                var movie = movies!.first
                movie?.releaseDate = "10/10/2018"
                
                it("should return empty date", closure: {
                    let movieController = MovieController()
                    expect(movieController.getMovieYear(movie: movie!)).to(equal(""))
                })
            })
        }
    }
}


