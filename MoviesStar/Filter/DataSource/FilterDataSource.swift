import UIKit

class FilterDataSource: BaseFilterDataSource, DataSourceFilterable {
    
    fileprivate(set) var items: [String]
    var selectedItem: String?
    
    init(items: [String]) {
        self.items = items
        super.init(dataSource: self)
    }
}
