//
//  BaseServiceSpec.swift
//  ios-trainning-projectTests
//
//  Created by Jose Freitas on 09/02/18.
//  Copyright © 2018 Mateus Gonçalves. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import ios_trainning_project

class APIClientSpec: QuickSpec {
    
    override func spec() {
        describe("APIClient") {
            
            context("when a endpoint is choosen"){
                var endpoint: Endpoints = .popular(page: 1)
                
                afterEach {
                    endpoint = .popular(page: 1)
                }
                
                it("should return the correct enpoint for popular movies"){
                    let correctEndpoint = "movie/popular"
                    expect(endpoint.description()).to(equal(correctEndpoint))
                }
                
                it("should return the correct url for genre"){
                    endpoint = .genre
                    expect(endpoint.description()).to(equal("genre/movie/list"))
                }
                
                it("should return the page value for popular movies"){
                    expect(endpoint.value()).to(equal("&page=1"))
                }
                
                it("should return the passed value for genre"){
                    endpoint = .genre
                    expect(endpoint.value()).to(equal(""))
                }
            }
        }
    }
}
    

