import UIKit

@testable import MoviesStar

class FavoritesDatasourceStub: FavoritesDatasource {
    var updateDatasourceCalled: Bool = false
    
    override func update(movies: [Movie]) {
        self.updateDatasourceCalled = true
    }
}
