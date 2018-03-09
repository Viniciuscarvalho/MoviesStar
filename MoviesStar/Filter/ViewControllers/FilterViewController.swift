import UIKit
import SnapKit

class FilterViewController: UIViewController {
    
    fileprivate var tableView: BasicTableView
    fileprivate var dataSource: BaseFilterDataSource
    
    init(tableViewDataSource: BaseFilterDataSource) {
        self.dataSource = tableViewDataSource
        self.tableView = BasicTableView(dataSource: tableViewDataSource, delegate: tableViewDataSource)
        super.init(nibName: nil, bundle: nil)
        self.view = tableView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
