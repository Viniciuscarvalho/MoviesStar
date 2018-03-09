//
//  MovieDetailViewControllerSpec.swift
//  ios-trainning-projectTests
//
//  Created by m.marques.goncalves on 20/02/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import ios_trainning_project

class MovieDetailViewControllerSpec: QuickSpec {
    
    var sut: MovieDetailViewController!
    
    override func spec() {
        
        describe("MovieDetailViewControllerSpec") {
            
            beforeEach {
                let data = LoadJson.loadListResultJson()
                let movieController = MovieController()
                let movies = movieController.add(data: data)
                let movie = movies?.first
                let genre = Genre(id: 1, name: "Drama")
                let dataSource = MovieDetailDataSource(genres: [genre])
                dataSource.movie = movie
                self.sut = MovieDetailViewController(dataSource: dataSource)
            }
            
            it("should create MovieDetailViewController correctly", closure: {
                expect(self.sut).toNot(beNil())
                
                expect(self.sut.view.subviews.first?.isKind(of: DetailView.self)).to(beTrue())
            })
            
            it("should call button", closure: {
                self.sut.viewWillAppear(true)
                self.sut.favoriteButtonTapped()
                expect(self.sut.dataSource).toNot(beNil())
            })
            
            context("when created with coder") {
                let sut = MovieDetailViewController(coder: NSCoder())
                it("should be nil"){
                    expect(sut).to(beNil())
                }
            }
        }
    }
}
