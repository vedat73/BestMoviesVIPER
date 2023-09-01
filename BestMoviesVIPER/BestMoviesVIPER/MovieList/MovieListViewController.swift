//
//  MovieListViewController.swift
//  BestMoviesMVVM
//
//  Created by Vedat Ozlu on 19.08.2023.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    
    private var movies : [MoviePresentation] = []
    var presenter: MovieListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.load()
    }
}

extension MovieListViewController: Storyboardable {
    static var storyboardName: String {
        "MovieList"
    }
}

extension MovieListViewController: MovieListViewProtocol {
    func handleOutput(_ output: MovieListPresenterOutput) {
        switch output {
            case .updateTitle(let title):
                self.title = title
            case .setLoading(_):
                //
                break
            case .showMovieList(let movies):
                self.movies = movies
                tableView.reloadData()
        }
    }
}

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath)
        let movie = movies[indexPath.row]
        
        if #available(iOS 14, *) {
            var movieContent = cell.defaultContentConfiguration()
            movieContent.text = movie.title
            movieContent.secondaryText = movie.detail
            cell.contentConfiguration = movieContent
        } else {
            cell.textLabel?.text = movie.title
            cell.detailTextLabel?.text = movie.detail
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
}

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectMovie(at: indexPath.row)
    }
}
