import UIKit

class FilterButton: UIButton {
    
    init(target: Any, selector: Selector) {
        let size = CGRect(x: 0, y: 0, width: 17, height: 19)
        super.init(frame: size)
        
        setup(target: target, selector: selector)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup(target: Any, selector: Selector) {
        
        self.setBackgroundImage(Assets.filter.image, for: .normal)
        self.addTarget(target, action: selector, for: .touchUpInside)
    }
}
