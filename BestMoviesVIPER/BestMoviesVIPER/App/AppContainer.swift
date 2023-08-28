//
//  AppContainer.swift
//  BestMoviesVIPER
//
//  Created by Vedat Ozlu on 26.08.2023.
//

import Foundation
import BestMoviesAPI
import MediaAPI

let app = AppContainer()

final class AppContainer {
    let router = AppRouter()
    let service = BestMoviesService()
    let mediaService = MediaService()
}
