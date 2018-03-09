//
//  FavoritesCellSpec.swift
//  ios-trainning-projectTests
//
//  Created by Rafael Aparecido de Freitas  on 26/02/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Nimble_Snapshots

@testable import ios_trainning_project

class FavoritesCellSpec: QuickSpec {
    
    var sut: FavoritesCell!
    
    override func spec() {
        
        describe("FavoritesCell") {
            
            context("when load cell") {
                beforeEach {
                    self.sut = Bundle.main.loadNibNamed("FavoritesCell", owner: nil, options: nil)?.first as! FavoritesCell
                    let movie = Movie(id: 1,
                                      title: "Thor",
                                      posterPath: nil,
                                      releaseDate: "2008-08-03",
                                      genreIds: [1,2],
                                      overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                    self.sut.setup(movie: movie)
                }
                
                it("should have valid snapshot") {
                    expect(self.sut) == snapshot("FavoritesCell")
                }
                
                afterEach {
                    self.sut.prepareForReuse()
                }
            }
            
            
        }
        
    }
    
    
}
