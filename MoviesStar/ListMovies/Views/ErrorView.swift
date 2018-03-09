import Foundation
import UIKit
import SnapKit

enum ErrorViewType {
    case Default, NoInternetConnection, NoSearchResults
}

final class ErrorView: UIView {
    
    private let DEFAULT_ERROR_TYPE = "Um erro ocorreu. Por favor tente novamente."
    private let NO_INTERNET_ERROR_TYPE = "Sem conexão com a internet. Por favor tente mais tarde."
    private let NO_SEARCH_RESULTS = "Sua busca não resultou em nenhum resultado."
    private var afterView: UIView?
    var errorType: ErrorViewType
    
    fileprivate lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir", size: 20.0)
        return label
    }()
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    init(in container: UIView, errorType: ErrorViewType = ErrorViewType.Default, dismissAfter milliseconds: Int? = nil, afterView: UIView? = nil) {
        self.errorType = errorType
        self.afterView = afterView
        super.init(frame: .zero)
        self.backgroundColor = UIColor.white
        
        buildHieratchy(containerView: container)
        buildConstraints()
        setup()
        
        if milliseconds != nil {
            self.dismiss(after: milliseconds!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("this class can not be initialized for NSCoder arg")
        return nil
    }
    
    private func buildHieratchy(containerView: UIView) {
        containerView.addSubview(self)
        self.addSubview(self.label)
        self.addSubview(self.imageView)
    }
    
    private func buildConstraints(){
        
        guard self.superview != nil else{
            debugPrint("ErrorView.superview property is nil")
            return
        }
        
        // Setup - self constraints
        self.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()

            if let afterView = self.afterView {
                make.top.equalTo(afterView.snp.bottom)
            } else {
                make.top.equalToSuperview()
            }
        }
        
        // Setup Image view
        
        self.imageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 200, height: 200))
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-40)
        }
        
        // Setup Label Constraints
        
        self.label.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.top.equalTo(self.imageView.snp.bottom).offset(16)
        }
    }
    
    // MARK:- Setup view Elements
    private func setup(){
        
        switch errorType {
        case .NoInternetConnection:
            self.label.text = NO_INTERNET_ERROR_TYPE
            self.imageView.image = UIImage(named:"temp_error_image")
        case .NoSearchResults:
            self.label.text = NO_SEARCH_RESULTS
            self.imageView.image = UIImage(named: "search_image_error")
            break
        default:
            self.label.text = DEFAULT_ERROR_TYPE
            self.imageView.image = UIImage(named:"temp_error_image")
        }
        
    }
    
    func dismiss() {
        self.removeFromSuperview()
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
    
    func dismiss(after milliseconds:Int) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(milliseconds)) {
            self.dismiss()
        }
    }
}
