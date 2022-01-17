//
//  WriteDiaryCoordinator.swift
//  KIDA
//
//  Created by Ian on 2022/01/17.
//

import UIKit

final class WriteDiaryCoordinator: Coordinatable {

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
        let writeDiaryReactor = WriteDiaryReactor()
        let writeDiaryViewController = WriteDiaryViewController(reactor: writeDiaryReactor)

        navigationController.pushViewController(writeDiaryViewController, animated: true)
    }
}
