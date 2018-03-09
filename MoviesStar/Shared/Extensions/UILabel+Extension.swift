import UIKit

extension UILabel {
    func setDefaultFont(customSize size: CGFloat?) {
        let size = size ?? 16
        self.font = UIFont(name: "Avenir", size: size)
    }
}
