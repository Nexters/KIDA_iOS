//
//  PopupCoordinator.swift
//  KIDA
//
//  Created by Ian on 2022/02/09.
//

import UIKit

final class PopupCoordinator: Coordinatable {

    /// PopupType
    enum PopupType {
        case info
        case error
    }

    // MARK: - Properties
    var childCoordinators: [Coordinatable] = []
    var parentCoordinator: Coordinatable?
    var navigationController: UINavigationController

    let popupType: PopupType

    // MARK: - Initializer
    init(navigationController: UINavigationController, popupType: PopupType) {
        self.navigationController = navigationController
        self.popupType = popupType
    }

    // MARK: - Mehtods
    func start() {
        let popupViewController: BaseViewController
        switch popupType {
        case .info:
            let popupInfoReactor = PopupInfoReactor()
            popupInfoReactor.delegate = self
            popupViewController = PopupInfoViewController(reactor: popupInfoReactor)

        case .error:
            let popupErrorReactor = PopupErrorReactor()
            popupViewController = PopupErrorViewController(reactor: popupErrorReactor)
        }

        guard let topViewController = navigationController.topViewController else {
            return
        }

        topViewController.modalPresentationStyle = .fullScreen
        topViewController.present(popupViewController,
                                  animated: true,
                                  completion: nil)
    }
}

extension PopupCoordinator: PopupInfoReactorDelegate {
    func didTapClose() {
        navigationController.dismiss(animated: true,
                                     completion: nil)
    }

    func didTapGotoSelect() {
        let keywordSelectCoordinator = KeywordSelectCoordinator(navigationController: navigationController)
        self.childCoordinators.append(keywordSelectCoordinator)
        keywordSelectCoordinator.parentCoordinator = self

        navigationController.dismiss(animated: true,
                                     completion: keywordSelectCoordinator.start)
    }
}
