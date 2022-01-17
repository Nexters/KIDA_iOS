//
//  HomeCoordinator.swift
//  KIDA
//
//  Created by Ian on 2022/01/15.
//

import UIKit

final class HomeCoordinator: Coordinatable {

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
        let homeViewReactor = HomeViewReactor()
        let homeViewController = HomeViewController()
        homeViewController.reactor = homeViewReactor
        navigationController.viewControllers = [homeViewController]
    }
}
