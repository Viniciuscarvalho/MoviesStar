//
//  MovieDetailViewController.swift
//  ios-trainning-project
//
//  Created by m.marques.goncalves on 19/02/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    var dataSource: MovieDetailDataSource
    private var loadingView: LoadingView = LoadingView()
    var detailView: DetailView?
    
    init(dataSource: MovieDetailDataSource) {
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("this class can not be initialized for NSCoder arg")
        return nil
    }
    
    override func loadView() {
        self.view = UIView()
        self.detailView = DetailView(superView: self.view, target: self, favoriteButtonSelector: #selector(favoriteButtonTapped))
    }
    
    @objc func favoriteButtonTapped() {
        guard let movie = dataSource.movie else { return }
        let movieController = MovieController()
        if movieController.isFavoriteMovie(movie: movie) {
            let movieController = MovieController()
            movieController.remove(id: movie.id)
            detailView?.isFavorite = false
        } else {
            let movieController = MovieController()
            movieController.save(movie: movie)
            detailView?.isFavorite = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.dataSource.movie?.title
        self.detailView?.configureView(dataSource: self.dataSource)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let movie = self.dataSource.movie {
            let movieController = MovieController()
            self.detailView?.isFavorite = movieController.isFavoriteMovie(movie: movie)
        }
    }
    
}
