import UIKit
import SnapKit

extension UIView {
    func applyGrayLine(toViews views: [UIView], withOffset offset: (leading: Int, top: Int)) {
        for view in views {
            let grayLine: UIView = {
                let view = UIView()
                view.backgroundColor = UIColor.lightGray
                return view
            }()
            
            self.addSubview(grayLine)
            
            grayLine.snp.makeConstraints({ (make) in
                make.top.equalTo(view.snp.bottom).offset(offset.top)
                make.leading.equalTo(self).offset(offset.leading)
                make.trailing.equalTo(self)
                make.height.equalTo(1)
            })
        }
    }
}
