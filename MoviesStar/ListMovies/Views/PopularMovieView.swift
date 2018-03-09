import Foundation
import UIKit
import SnapKit

class PopularMovieView: UIView, CodeView{
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var searchBar: SearchBar = SearchBar()
    var loadingView: LoadingView = LoadingView()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.minimumLineSpacing = 15
        return flowLayout
    }()
    
    func buildHierarchy() {
        self.addSubview(self.collectionView)
        self.addSubview(self.searchBar)
        self.addSubview(self.loadingView)
    }
    
    func buildConstraints() {
        self.searchBar.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self)
        }
        
        self.collectionView.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(56)
            make.bottom.equalTo(self)
        }
        
        self.loadingView.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(self)
        }
    }
    
    func startLoading() {
        self.loadingView.start()
    }
    
    func stopLoading() {
        self.loadingView.stop()
    }
}
