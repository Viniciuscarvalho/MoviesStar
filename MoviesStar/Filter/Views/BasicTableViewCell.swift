import UIKit
import SnapKit

class BasicTableViewCell: UITableViewCell, CodeView {
    
    static fileprivate(set) var identifier: String = "\(BasicTableViewCell.self)"
    
    lazy var customInfoButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.darkYellow, for: .normal)
        button.titleLabel?.textAlignment = .right
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func configure(text: String, customInfo: String?) {
        self.textLabel?.text = text
        self.clearCustomInfo()
        if let customInfo = customInfo {
            self.with(title: customInfo)
        }
    }
    
    func configure(text: String, isChecked: Bool) {
        self.textLabel?.text = text
        self.clearCustomInfo()
        if isChecked {
            self.check()
        } else {
            self.uncheck()
        }
    }
    
    func configure() {
        self.accessoryType = .disclosureIndicator
        if let label = self.textLabel {
            self.applyGrayLine(toViews: [label], withOffset: (leading: 20, top: 5))
        }
    }
    
    func buildHierarchy() {
        self.contentView.addSubview(customInfoButton)
    }
    
    func buildConstraints() {
        self.customInfoButton.snp.makeConstraints { (make) in
            make.width.lessThanOrEqualTo(180)
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
    }
    
    func with(title: String) {
        self.customInfoButton.setTitle(title, for: .normal)
    }
    
    func clearCustomInfo() {
        self.customInfoButton.setTitle("", for: .normal)
    }
    
    func check() {
        self.customInfoButton.setImage(Assets.check.image, for: .normal)
    }
    
    func uncheck() {
        self.customInfoButton.setImage(nil, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
