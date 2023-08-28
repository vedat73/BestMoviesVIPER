//
//  MovieDetailPresenter.swift
//  BestMoviesVIPER
//
//  Created by Vedat Ozlu on 26.08.2023.
//

import Foundation
import struct BestMoviesAPI.Movie
import class UIKit.UIImage
import MediaAPI

final class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    unowned var view: MovieDetailViewProtocol
    private let movie: Movie
    
    init(view: MovieDetailViewProtocol, movie: Movie) {
        self.view = view
        self.movie = movie
    }
    
    func load() {
        let movieDetaiPresentation = MovieDetailPresentation(movie: movie)
        view.update(movieDetaiPresentation)
        app.mediaService.downloadImage(from: movieDetaiPresentation.imageUrl ?? "") {[weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let image):
                    self.view.updateImage(image)
                case .failure(_):
                    self.view.updateImage(UIImage(named: "ic_movie")!)
            }
        }
    }
}
