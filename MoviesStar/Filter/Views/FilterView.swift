import UIKit
import SnapKit

class FilterView: UIView, CodeView {
    
    fileprivate let tableViewDataSource: UITableViewDataSource
    fileprivate let tableViewDelegate: UITableViewDelegate
    fileprivate let target: Any
    fileprivate let applyButtonSelector: Selector
    
    lazy var tableView: BasicTableView = {
        let tableView = BasicTableView(dataSource: self.tableViewDataSource, delegate: self.tableViewDelegate)
        return tableView
    }()
    
    lazy var applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .lightYellow
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    init(tableViewDataSource: UITableViewDataSource, tableViewDelegate: UITableViewDelegate, target: Any, applyButtonSelector: Selector) {
        self.tableViewDataSource = tableViewDataSource
        self.tableViewDelegate = tableViewDelegate
        self.target = target
        self.applyButtonSelector = applyButtonSelector
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy() {
        self.addSubview(tableView)
        self.addSubview(applyButton)
    }
    
    func buildConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        applyButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-100)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(tableView.snp.bottom)
            
            make.height.equalTo(40)
        }
    }
    
    func configure() {
        self.backgroundColor = .white
        applyButton.addTarget(self.target, action: self.applyButtonSelector, for: .touchUpInside)
    }
}
