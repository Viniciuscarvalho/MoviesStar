//
//  PopularMoviesDatasourceStub.swift
//  ios-trainning-projectTests
//
//  Created by Rafael Aparecido de Freitas  on 28/02/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//

import Foundation

import UIKit

@testable import ios_trainning_project

class PopularMoviesDataSourceStub: PopularMoviesDataSource{
    
    var postNotificationCalled: Bool = false
    var postItemSelectionNotificationCalled: Bool = false
    
    override func postNotification() {
        super.postNotification()
        self.postNotificationCalled = true
    }
    
    override func postItemSelectionNotification() {
        super.postItemSelectionNotification()
        self.postItemSelectionNotificationCalled = true
    }
}

