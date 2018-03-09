import Foundation

protocol DataSourceFilterable {
    var items: [String] {get}
    var selectedItem: String? {get set}
    
    mutating func numberOfItems() -> Int
    func getItem(byIndexPath indexPath: IndexPath) -> String
    mutating func select(item: String)
    mutating func deselectItem()
}

extension DataSourceFilterable {
    func numberOfItems() -> Int {
        return items.count
    }
    
    func getItem(byIndexPath indexPath: IndexPath) -> String {
        return items[indexPath.row]
    }
    
    mutating func select(item: String) {
        selectedItem = item
    }
    
    mutating func deselectItem() {
        selectedItem = nil
    }
}
