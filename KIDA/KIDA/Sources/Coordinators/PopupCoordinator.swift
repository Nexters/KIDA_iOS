//
//  PopupCoordinator.swift
//  KIDA
//
//  Created by Ian on 2022/02/09.
//

import UIKit

/// PopupType
enum PopupType {
    case info
    case error
}

final class PopupCoordinator: Coordinatable {


    // MARK: - Properties
    var childCoordinators: [Coordinatable] = []
    var parentCoordinator: Coordinatable?
    var navigationController: UINavigationController

    private let popupType: PopupType

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
            popupErrorReactor.delegate = self
            popupViewController = PopupErrorViewController(reactor: popupErrorReactor)
        }

        guard let topViewController = navigationController.topViewController else {
            return
        }

        popupViewController.modalPresentationStyle = .overFullScreen
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

extension PopupCoordinator: PopupErrorReactorDelegate {
    func didTapClosePopupError() {
        navigationController.dismiss(animated: true,
                                     completion: nil)
    }
}
