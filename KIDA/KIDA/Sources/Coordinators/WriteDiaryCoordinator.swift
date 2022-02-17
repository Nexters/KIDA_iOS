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
        writeDiaryReactor.delegate = self
        let writeDiaryViewController = WriteDiaryViewController(reactor: writeDiaryReactor)

        navigationController.pushViewController(writeDiaryViewController, animated: true)
    }

    func startWithPush() -> WriteDiaryViewController {
        let writeDiaryReactor = WriteDiaryReactor()
        writeDiaryReactor.delegate = self
        let writeDiaryViewController = WriteDiaryViewController(reactor: writeDiaryReactor)

        return writeDiaryViewController
    }
    
    func startWithEdit() {
        let writeDiaryReactor = WriteDiaryReactor()
        writeDiaryReactor.delegate = self
        let writeDiaryViewController = WriteDiaryViewController(reactor: writeDiaryReactor)
        
        navigationController.pushViewController(writeDiaryViewController, animated: true)
    }
}

extension WriteDiaryCoordinator: WriteDiaryReactorDelegate {
    func didWriteDiary() {
        self.navigationController.dismiss(animated: true, completion: { [weak self] in
            guard let diaryListCoordinator = self?.parentCoordinator as? DiaryListCoordinator else {
                return
            }

            diaryListCoordinator.reloadDiaryList()
        })
    }
}
