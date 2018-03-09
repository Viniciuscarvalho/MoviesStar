import UIKit

class BaseFilterDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    fileprivate var dataSource: DataSourceFilterable
    
    init(dataSource: DataSourceFilterable) {
        self.dataSource = dataSource
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasicTableViewCell.identifier, for: indexPath) as? BasicTableViewCell else {
            fatalError("Cell should be instanceated")
        }
        
        cell.accessoryType = .none
        
        let item = dataSource.getItem(byIndexPath: indexPath)
        let isChecked = itemWasSelected(item: item)
        cell.configure(text: item, isChecked: isChecked)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let item = self.dataSource.getItem(byIndexPath: indexPath)
        itemWasTapped(item: item)
        
        tableView.reloadData()
    }
    
    func itemWasTapped(item: String) {
        if itemWasSelected(item: item) {
            self.dataSource.deselectItem()
        } else {
            self.dataSource.select(item: item)
        }
    }
    
    func itemWasSelected(item: String) -> Bool {
        if let selectedItem = dataSource.selectedItem, selectedItem == item {
            return true
        } else {
            return false
        }
    }
}
