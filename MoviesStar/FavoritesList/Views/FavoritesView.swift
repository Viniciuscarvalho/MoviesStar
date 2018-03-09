import UIKit
import SnapKit

class FavoritesView: UIView, CodeView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.frame)
        tableView.backgroundColor = .clear
        tableView.separatorColor = .white
        tableView.allowsSelection = false
        tableView.rowHeight = 116
        return tableView
    }()
    
    lazy var removeFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Remove Filter", for: .normal)
        button.backgroundColor = UIColor.pastelPurple
        button.setTitleColor(UIColor.lightYellow, for: .normal)
        return button
    }()
    
    init(target: Any, removeFilterSelector: Selector){
        super.init(frame: .zero)
        self.removeFilterButton.addTarget(target, action: removeFilterSelector, for: .touchUpInside)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy() {
        self.addSubview(self.tableView)
        self.addSubview(self.removeFilterButton)
    }
    
    func buildConstraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self.removeFilterButton.snp.bottom)
            make.bottom.equalTo(self)
        }
        self.removeFilterButton.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.height.equalTo(0)
        }
        self.hideRemoveFilterButton()
    }
    
    func updateButtonConstraint(height: Int) {
        self.removeFilterButton.snp.updateConstraints { (make) in
            make.height.equalTo(height)
        }
    }
    
    func showRemoveFilterButton() {
        self.updateButtonConstraint(height: 54)
        self.removeFilterButton.isHidden = false
    }
    
    @objc func hideRemoveFilterButton() {
        self.updateButtonConstraint(height: 0)
        self.removeFilterButton.isHidden = true
    }
    
    func configure() {
        self.backgroundColor = .white
    }
}
