//
//  MovieDetailContracts.swift
//  BestMoviesVIPER
//
//  Created by Vedat Ozlu on 26.08.2023.
//

import class UIKit.UIImage

protocol MovieDetailPresenterProtocol {
    func load()
}

protocol MovieDetailViewProtocol: AnyObject {
    func update(_ presentation: MovieDetailPresentation)
    func updateImage(_ image: UIImage)
}
