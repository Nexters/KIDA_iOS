//
//  SelectedKeywordCoordinator.swift
//  KIDA
//
//  Created by Ian on 2022/01/15.
//

import UIKit

final class SelectedKeywordCoordinator: Coordinatable {

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
        let selectedKeywordReactor = SelectedKeywordReactor()
        selectedKeywordReactor.delegate = self
        let selectedkeywordViewController = SelectedKeywordViewController(reactor: selectedKeywordReactor)
        navigationController.pushViewController(selectedkeywordViewController, animated: true)
    }
}

extension SelectedKeywordCoordinator: SelectedKeywordReactorDelegate {
    func didTapGotoWrite() {
        let diaryListCoordinator = DiaryListCoordinator(navigationController: navigationController)
        diaryListCoordinator.parentCoordinator = self
        self.childCoordinators.append(diaryListCoordinator)

        diaryListCoordinator.startWithWrite()
    }

    func didTapRePick() {
        let keywordSelectCoordinator = KeywordSelectCoordinator(navigationController: navigationController)
        keywordSelectCoordinator.parentCoordinator = self
        self.childCoordinators.append(keywordSelectCoordinator)

        keywordSelectCoordinator.start()
        print("⚠️⚠️⚠️ [Ian] \(#function) \(#file) - \(#line): ")
    }
}
