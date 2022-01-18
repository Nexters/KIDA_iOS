//
//  SplashCoordinator.swift
//  KIDA
//
//  Created by Ian on 2022/01/17.
//

import UIKit

final class SplashCoordinator: Coordinatable {

    // MARK: - Properties
    var childCoordinators: [Coordinatable] = []
    var parentCoordinator: Coordinatable?
    var navigationController: UINavigationController

    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Methods
    func start() {
        let splashViewReactor = SplashViewReactor()
        splashViewReactor.delegate = self
        let splashViewController = SplashViewController(reactor: splashViewReactor)

        navigationController.pushViewController(splashViewController, animated: false)
    }
}

extension SplashCoordinator: SplashViewReactorDelegate {
    func showHome() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.parentCoordinator = self
        self.childCoordinators.append(homeCoordinator)

        homeCoordinator.start()
    }
}