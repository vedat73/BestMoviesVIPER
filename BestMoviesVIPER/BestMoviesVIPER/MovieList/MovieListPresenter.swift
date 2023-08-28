//
//  MovieListPresenter.swift
//  BestMoviesVIPER
//
//  Created by Vedat Ozlu on 26.08.2023.
//

import Foundation

final class MovieListPresenter: MovieListPresenterProtocol {
    
    private unowned var view: MovieListViewProtocol // it will act like view delegate
    private let interactor: MovieListInteractorProtocol
    private let router: MovieListRouterProtocol
    
    init(view: MovieListViewProtocol, interactor: MovieListInteractorProtocol, router: MovieListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        
        self.interactor.delegate = self
    }
    
    func load() {
        view.handleOutput(.updateTitle("Movies"))
        interactor.load()
    }
    
    func selectMovie(at index: Int) {
        interactor.selectMovie(at: index)
    }
}

extension MovieListPresenter: MovieListInteractorDelegate {
    func handleOutput(_ output: MovieListInteractorOutput) {
        switch output {
            case .setLoading(let isLoading):
                view.handleOutput(.setLoading(isLoading))
            case .showMovieList(let movies):
                let moviePresentations = movies.map{ MoviePresentation(movie: $0) }
                view.handleOutput(.showMovieList(moviePresentations))
            case .showMovieDetail(let movie):
                router.navigate(to: .detail(movie))
        }
    }
}
