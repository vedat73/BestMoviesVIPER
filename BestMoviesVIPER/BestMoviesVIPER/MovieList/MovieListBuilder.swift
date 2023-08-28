//
//  MovieListBuilder.swift
//  BestMoviesMVVM
//
//  Created by Vedat Ozlu on 20.08.2023.
//

import UIKit

final class MovieListBuilder {
    
    static func make() -> MovieListViewController {
        let storyboard = UIStoryboard(name: "MovieList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
        
        let router = MovieListRouter(view: viewController)
        let interactor = MovieListInteractor(service: app.service)
        let presenter = MovieListPresenter(view: viewController, interactor: interactor, router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
