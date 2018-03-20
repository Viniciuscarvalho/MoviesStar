import Foundation

import UIKit

@testable import MoviesStar

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

