//
//  DiaryListViewController.swift
//  KIDA
//
//  Created by choidam on 2022/01/17.
//

final class DiaryListViewController: BaseViewController, ServiceDependency {

    // MARK: UI

    // MARK: Property
    
    var reactor: DiaryListViewReactor?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupViews() {
    }

    override func setupLayoutConstraints() {
    }

    func bind(reactor: DiaryListViewReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
}

extension DiaryListViewController {

    func bindState(reactor: DiaryListViewReactor){
    }

    func bindAction(reactor: DiaryListViewReactor){
    }
}
