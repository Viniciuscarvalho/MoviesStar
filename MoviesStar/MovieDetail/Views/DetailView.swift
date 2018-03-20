import UIKit
import SnapKit

class DetailView: UIView, CodeView {
    
    fileprivate let containerView: UIView
    fileprivate let target: Any
    fileprivate let favoriteButtonSelector: Selector
    
    var isFavorite: Bool = false {
        didSet {
            setFavorite(isFavorite: self.isFavorite)
        }
    }

    init(superView: UIView, target: Any, favoriteButtonSelector: Selector) {
        self.containerView = superView
        self.target = target
        self.favoriteButtonSelector = favoriteButtonSelector
        super.init(frame: superView.frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("this class can not be initialized for NSCoder arg")
        return nil
    }
    
    //MARK: SetUp Views
    lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = Assets.logo.image
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setDefaultFont(customSize: nil)
        return label
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.setDefaultFont(customSize: nil)
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(Assets.favoriteEmpty.image, for: .normal)
        return button
    }()
    
    lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.setDefaultFont(customSize: nil)
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.setDefaultFont(customSize: 14)
        return label
    }()
    
    // MARK - Configure
    func configure() {
        self.backgroundColor = UIColor.white
        addAction(target: self.target, selector: self.favoriteButtonSelector)
    }
    
    //MARK: SetUp Hierarchy
    func buildHierarchy() {
        self.containerView.addSubview(self)
        self.addSubview(movieImage)
        self.addSubview(titleLabel)
        self.addSubview(favoriteButton)
        self.addSubview(releaseDateLabel)
        self.addSubview(genreLabel)
        self.addSubview(overviewLabel)
        
        let views = [titleLabel, releaseDateLabel, genreLabel]
        self.applyGrayLine(toViews: views, withOffset: (leading: 10, top: 10))
    }
    
    //MARK: SetUp Constraints
    func buildConstraints() {
        self.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        movieImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(15)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.height.equalTo(250)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(movieImage.snp.bottom).offset(20)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(favoriteButton.snp.leading).offset(-10)
        }
        
        favoriteButton.snp.makeConstraints { (make) in
            make.top.equalTo(movieImage.snp.bottom).offset(20)
            make.trailing.equalTo(self).offset(-10)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        releaseDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
        }
        
        genreLabel.snp.makeConstraints { (make) in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(20)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
        }
        
        overviewLabel.snp.makeConstraints { (make) in
            make.top.equalTo(genreLabel.snp.bottom).offset(20)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
        }
    }
    
    fileprivate func addAction(target: Any, selector: Selector) {
        self.favoriteButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setFavorite(isFavorite: Bool) {
        if isFavorite{
            favoriteButton.setBackgroundImage(Assets.favoriteFull.image, for: .normal)
        }else{
            favoriteButton.setBackgroundImage(Assets.favoriteGray.image, for: .normal)
        }
    }
}

extension DetailView {
    
    func configureView(dataSource: MovieDetailDataSource) {
        if let movie = dataSource.movie {
            let movieController = MovieController()
            self.titleLabel.text = movie.title
            self.overviewLabel.text = movie.overview
            self.releaseDateLabel.text = movieController.getMovieYear(movie: movie)
            
            if let posterPath = movie.posterPath {
                let imageUrl = APIClient.imageBaseURL + posterPath
                self.movieImage.kf.indicatorType = .activity
                self.movieImage.kf.setImage(with: URL(string: imageUrl))
            }
            
            let genreList = dataSource.genreNameList()
            self.genreLabel.text = genreList.joined(separator: ", ")
        }
    }
}
