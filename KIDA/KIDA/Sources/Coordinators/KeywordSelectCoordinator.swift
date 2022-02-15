//
//  KeywordSelectCoordinator.swift
//  KIDA
//
//  Created by choidam on 2022/01/23.
//
import UIKit

final class KeywordSelectCoordinator: Coordinatable {

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
        if navigationController.topViewController is KeywordSelectViewController {
            return
        }

        let keywordSelectReactor = KeywordSelectViewReactor()
        keywordSelectReactor.delegate = self
        let keywordSelectViewController = KeywordSelectViewController()
        keywordSelectViewController.reactor = keywordSelectReactor
        keywordSelectViewController.navigationItem.title = .navBarDateTitle
        navigationController.viewControllers = [keywordSelectViewController]
    }
}

extension KeywordSelectCoordinator: KeywordSelectReactorDelegate {
    func didSelectCard(cardIndex: Int) {
        let selectedKeywordCoordinator = SelectedKeywordCoordinator(navigationController: navigationController)
        selectedKeywordCoordinator.parentCoordinator = self
        self.childCoordinators.append(selectedKeywordCoordinator)

        selectedKeywordCoordinator.startWithSelectedCard(cardIndex)
    }
}
