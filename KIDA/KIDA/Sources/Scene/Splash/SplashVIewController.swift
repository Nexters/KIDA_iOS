//
//  SplashVIewController.swift
//  KIDA
//
//  Created by Ian on 2022/01/17.
//

import UIKit
import RxSwift

final class SplashViewController: BaseViewController, ServiceDependency {

    // MARK: - Properties
    private weak var splashImageView: UIImageView!
    private var reactor: SplashViewReactor

    // MARK: - Initializer
    init(reactor: SplashViewReactor) {
        self.reactor = reactor

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bind(reactor: reactor)
        rx.viewDidAppear
            .asDriver()
            .drive(onNext: { [weak self] in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [weak self] in
                    self?.reactor.action.onNext(.showKeywordSelect)
                })
            })
            .disposed(by: disposeBag)
    }

    override func setupViews() {
        view.backgroundColor = .systemGray

        self.splashImageView = UIImageView().then {
            $0.image = UIImage(named: "splash")
            $0.contentMode = .scaleAspectFill
            view.addSubview($0)
        }
    }

    override func setupLayoutConstraints() {
        splashImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(reactor: SplashViewReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
}

private extension SplashViewController {
    func bindAction(reactor: SplashViewReactor) {
    }

    func bindState(reactor: SplashViewReactor) {
        reactor.state
            .subscribe()
            .disposed(by: disposeBag)
    }
}
