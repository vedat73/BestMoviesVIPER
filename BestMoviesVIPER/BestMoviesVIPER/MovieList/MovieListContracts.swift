//
//  MovieListContract.swift
//  BestMoviesVIPER
//
//  Created by Vedat Ozlu on 26.08.2023.
//

import Foundation
import struct BestMoviesAPI.Movie

// MARK: - Interactor

protocol MovieListInteractorProtocol: AnyObject {
    var delegate: MovieListInteractorDelegate? { get set }
    func load()
    func selectMovie(at index: Int)
}

enum MovieListInteractorOutput: Equatable {
    case setLoading(Bool)
    case showMovieList([Movie])
    case showMovieDetail(Movie)
}

protocol MovieListInteractorDelegate {
    func handleOutput(_ output: MovieListInteractorOutput)
}

// MARK: - Presenter

protocol MovieListPresenterProtocol: AnyObject {
    func load()
    func selectMovie(at index: Int)
}

enum MovieListPresenterOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case showMovieList([MoviePresentation])
}

// MARK: - View

protocol MovieListViewProtocol: AnyObject {
    func handleOutput(_ output: MovieListPresenterOutput)
}

// MARK: - Router

enum MovieListRoute: Equatable {
    case detail(Movie)
}

protocol MovieListRouterProtocol: AnyObject {
    func navigate(to route: MovieListRoute)
}
