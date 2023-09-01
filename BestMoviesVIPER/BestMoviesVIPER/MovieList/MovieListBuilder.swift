//
//  MovieListBuilder.swift
//  BestMoviesMVVM
//
//  Created by Vedat Ozlu on 20.08.2023.
//

import UIKit

final class MovieListBuilder {
    
    static func make() -> MovieListViewController {
        let viewController = MovieListViewController.instantiate()
        
        let router = MovieListRouter(view: viewController)
        let interactor = MovieListInteractor(service: app.service)
        let presenter = MovieListPresenter(view: viewController, interactor: interactor, router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
