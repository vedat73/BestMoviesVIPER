//
//  MovieDetailBuilder.swift
//  BestMoviesMVVM
//
//  Created by Vedat Ozlu on 20.08.2023.
//

import UIKit
import BestMoviesAPI

final class MovieDetailBuilder {
    
    static func make(with movie: Movie) -> MovieDetailViewController {
        let viewController = MovieDetailViewController.instantiate()
        let presenter = MovieDetailPresenter(view: viewController, movie: movie)
        viewController.presenter = presenter
        return viewController
    }
}
