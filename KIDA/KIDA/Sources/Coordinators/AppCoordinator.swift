//
//  AppCoordinator.swift
//  KIDA
//
//  Created by Ian on 2022/01/15.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinatable {

    // MARK: - Properties
    var childCoordinators: [Coordinatable] = []
    var parentCoordinator: Coordinatable?
    var navigationController: UINavigationController
    let window: UIWindow

    // MARK: - Initializer
    init(window: UIWindow) {
        self.window = window
        self.window.makeKeyAndVisible()
        self.navigationController = UINavigationController()
        self.window.rootViewController = navigationController
    }

    // MARK: - Methods
    func start() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.parentCoordinator = self
        self.childCoordinators.append(homeCoordinator)

        homeCoordinator.start()
    }
}
