//
//  DiaryListCoordinator.swift
//  KIDA
//
//  Created by choidam on 2022/01/17.
//

import UIKit

final class DiaryListCoordinator: Coordinatable {

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
        let diaryListReactor = DiaryListViewReactor()
        let diaryListViewController = DiaryListViewController()
        diaryListViewController.reactor = diaryListReactor
        navigationController.viewControllers = [diaryListViewController]
    }
}

