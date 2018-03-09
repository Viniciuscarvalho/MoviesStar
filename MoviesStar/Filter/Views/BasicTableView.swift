import UIKit
import SnapKit

class BasicTableView: UITableView {
    
    init(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        super.init(frame: .zero, style: .plain)
        
        self.dataSource = dataSource
        self.delegate = delegate
        self.rowHeight = 55
        
        registerCell()
        configure()
    }
    
    fileprivate func registerCell() {
        self.register(BasicTableViewCell.self, forCellReuseIdentifier: BasicTableViewCell.identifier)
    }
    
    fileprivate func configure() {
        self.separatorStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
