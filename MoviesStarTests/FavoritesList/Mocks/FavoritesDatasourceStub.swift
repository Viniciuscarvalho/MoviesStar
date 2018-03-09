//
//  FavoritesDatasourceStub.swift
//  ios-trainning-projectTests
//
//  Created by Jose Freitas on 26/02/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//

import UIKit

@testable import ios_trainning_project

class FavoritesDatasourceStub: FavoritesDatasource {
    var updateDatasourceCalled: Bool = false
    
    override func update(movies: [Movie]) {
        self.updateDatasourceCalled = true
    }
}
