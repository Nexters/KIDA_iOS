//
//  PopupErrorViewController.swift
//  KIDA
//
//  Created by Ian on 2022/02/09.
//

import Foundation

final class PopupErrorViewController: BaseViewController, ServiceDependency {

    // MARK: - Properties

    private let reactor: PopupErrorReactor


    // MARK: - Initializer
    init(reactor: PopupErrorReactor) {
        self.reactor = reactor

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupViews() {

    }

    override func setupLayoutConstraints() {

    }

    func bind(reactor: PopupErrorReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
}

private extension PopupErrorViewController {
    func bindAction(_ reactor: PopupErrorReactor) {
        reactor.action
            .subscribe()
            .disposed(by: disposeBag)
    }

    func bindState(_ reactor: PopupErrorReactor) {
        reactor.state
            .subscribe()
            .disposed(by: disposeBag)
    }
}
