//
//  MovieListInteractor.swift
//  BestMoviesVIPER
//
//  Created by Vedat Ozlu on 26.08.2023.
//

import Foundation
import BestMoviesAPI

final class MovieListInteractor: MovieListInteractorProtocol {
    
    var delegate: MovieListInteractorDelegate?
    
    private let service: BestMoviesServiceProtocol
    
    private var movies: [Movie] = []
    
    init(service: BestMoviesServiceProtocol) {
        self.service = service
    }
    
    func load() {
        delegate?.handleOutput(.setLoading(true))
        service.fetchBestMovies { [weak self] result in
            guard let self = self else { return }
            self.delegate?.handleOutput(.setLoading(false))
            
            switch result {
                case .success(let value):
                    self.movies = value.entry
                    self.delegate?.handleOutput(.showMovieList(value.entry))
                case .failure(let error):
                    print(error)
            }
            
        }
    }
    
    func selectMovie(at index: Int) {
        let movie = movies[index]
        delegate?.handleOutput(.showMovieDetail(movie))
    }
    
}
 
