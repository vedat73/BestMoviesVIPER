//
//  AppRouter.swift
//  BestMoviesVIPER
//
//  Created by Vedat Ozlu on 26.08.2023.
//

import UIKit

final class AppRouter {
    var window: UIWindow?
    
    func start(windowScene: UIWindowScene) {
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let viewController =  MovieListBuilder.make()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
