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
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(splashViewController, animated: false)
    }
}

extension SplashCoordinator: SplashViewReactorDelegate {
    func showNextScene() {
        navigationController.navigationBar.isHidden = false
        
        let didWrite = PersistentStorage.shared.didWriteTodayDiary()
        
        if didWrite {
            showDiaryList()
        } else {
            showKeywordSelect()
        }
    }
    
    func showKeywordSelect(){
        let keywordSelectCoordinator = KeywordSelectCoordinator(navigationController: navigationController)
        keywordSelectCoordinator.parentCoordinator = self
        self.childCoordinators.append(keywordSelectCoordinator)

        keywordSelectCoordinator.start()
    }
    
    func showDiaryList(){
        
        let diaryListCoordinator = DiaryListCoordinator(navigationController: navigationController)
        diaryListCoordinator.parentCoordinator = self
        self.childCoordinators.append(diaryListCoordinator)
        
        diaryListCoordinator.start()
        
    }
}
