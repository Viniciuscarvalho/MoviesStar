import Foundation

struct DataSourceFilterable {
    var items: [String]
    var selectedItem: String?
    
    init(items: [String] = [], selectedItem: String? = nil) {
        self.items = items
        self.selectedItem = selectedItem
    }
    
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

