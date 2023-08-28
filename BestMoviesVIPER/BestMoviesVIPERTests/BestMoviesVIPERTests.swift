//
//  BestMoviesVIPERTests.swift
//  BestMoviesVIPERTests
//
//  Created by Vedat Ozlu on 26.08.2023.
//

import XCTest
@testable import BestMoviesVIPER
@testable import BestMoviesAPI

final class BestMoviesVIPERTests: XCTestCase {
    
    private var presenter: MovieListPresenter!
    private var interactor: MovieListInteractor!
    private var service: MockService!
    private var view: MockMovieListView!
    private var router: MockMovieListRouter!
    
    override func setUpWithError() throws {
        service = MockService()
        interactor = MovieListInteractor(service: service)
        view = MockMovieListView()
        router = MockMovieListRouter()
        presenter = MovieListPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
    }
    
    func testLoad() throws {
        // Given:
        let movie1 = try ResourceLoader.loadMovie(resource: .movie1)
        let movie2 = try ResourceLoader.loadMovie(resource: .movie2)
        service.movies = [movie1, movie2]
        
        // When:
        view.viewDidLoad()
        
        // Then:
        XCTAssertEqual(view.outputs.count, 4)
        
        let output = try view.outputs.element(at: 0)
        switch output {
            case .updateTitle:
                break
            default:
                XCTFail()
        }
        
        XCTAssertEqual(try view.outputs.element(at: 1), .setLoading(true))
        XCTAssertEqual(try view.outputs.element(at: 2), .setLoading(false))
        
//        let expectedMovies = service.movies.map { MoviePresentation(movie: $0) }
//        XCTAssertEqual(try view.outputs.element(at: 3), .showMovieList(expectedMovies))
    }
    
    func testSelectMovie() throws {
        // Given:
        let movie1 = try ResourceLoader.loadMovie(resource: .movie1)
        let movie2 = try ResourceLoader.loadMovie(resource: .movie2)
        service.movies = [movie1, movie2]
        view.viewDidLoad()
        
        // When:
        view.selectMovie(at: 0)
        
        // Then:
        let expectedMovie = try service.movies.element(at: 0)
        XCTAssertEqual(try router.routes.element(at: 0), .detail(expectedMovie))
    }
}

private final class MockMovieListView: MovieListViewProtocol {
    
    var presenter: MovieListPresenter!
    var outputs: [MovieListPresenterOutput] = []
    
    // fake viewDidLoad
    func viewDidLoad() {
        presenter.load()
    }
    
    func selectMovie(at index: Int) {
        presenter.selectMovie(at: index)
    }
    
    func handleOutput(_ output: MovieListPresenterOutput) {
        outputs.append(output)
    }
}

private final class MockMovieListRouter: MovieListRouterProtocol {
    var routes: [MovieListRoute] = []
    
    func navigate(to route: MovieListRoute) {
        routes.append(route)
    }
}

private final class MockService: BestMoviesServiceProtocol {
    
    var movies: [Movie] = []
    
    func fetchBestMovies(completion: @escaping (BestMoviesAPI.Result<BestMoviesAPI.BestMoviesResponse>) -> Void) {
        completion(.success(BestMoviesResponse(entry: movies)))
    }
}

extension Array { //for preventing crash during test
    
    struct IndexOutOfBoundsError: Error { }
    
    func element(at index: Int) throws -> Element {
        guard index >= 0 && index < self.count else {
            throw IndexOutOfBoundsError()
        }
        return self[index]
    }
}
