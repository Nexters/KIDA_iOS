//
//  HomeViewController.swift
//  KIDA
//
//  Created by Ian on 2022/01/15.
//

import UIKit

final class HomeViewController: BaseViewController, ServiceDependency {

    // MARK: Property
    
    var reactor: HomeViewReactor?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupViews() {
    }

    override func setupLayoutConstraints() {
    }

    func bind(reactor: HomeViewReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
}

private extension HomeViewController {

    func bindState(reactor: HomeViewReactor){
    }

    func bindAction(reactor: HomeViewReactor){
    }
}
