import Foundation

protocol CodeView {
    func buildHierarchy()
    func buildConstraints()
    func configure()
    func setupView()
}

extension CodeView {
    func setupView() {
        buildHierarchy()
        buildConstraints()
        configure()
    }
    
    func configure() {}
}
