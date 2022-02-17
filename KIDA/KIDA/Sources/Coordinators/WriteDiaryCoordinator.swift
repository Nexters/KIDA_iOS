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
    
    func startWithEdit(diary: Diary) {
        let diaryModel: DiaryModel = DiaryModel(content: diary.content ?? "",
                                                createdAt: diary.createdAt ?? Date(),
                                                keyword: diary.keyword ?? "",
                                                title: diary.title ?? "")
        
        let writeDiaryReactor = WriteDiaryReactor(isEditing: true, diary: diaryModel)
        writeDiaryReactor.delegate = self
        let writeDiaryViewController = WriteDiaryViewController(reactor: writeDiaryReactor)
        
        let navi = UINavigationController(rootViewController: writeDiaryViewController)
        navi.modalPresentationStyle = .overFullScreen
        
        navigationController.topViewController?.present(navi, animated: true, completion: nil)
        
        
        
//        writeDiaryViewController.modalPresentationStyle = .overFullScreen
//
//        navigationController.topViewController?.present(writeDiaryViewController,
//                                                        animated: true,
//                                                        completion: nil)
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
