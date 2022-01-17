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
    private weak var splashImage: UIImageView!
    private weak var demoLabel: UILabel!
    private var reactor: SplashViewReactor
    private let showHomeSubjet = PublishSubject<Void>()

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
                    self?.showHomeSubjet.onNext(())
                })
            })
            .disposed(by: disposeBag)
    }

    override func setupViews() {
        view.backgroundColor = .systemGray

        self.demoLabel = UILabel().then {
            $0.text = "Splash"
            $0.font = .systemFont(ofSize: 20, weight: .bold)
            view.addSubview($0)
        }
    }

    override func setupLayoutConstraints() {
        demoLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    func bind(reactor: SplashViewReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
}

private extension SplashViewController {
    func bindAction(reactor: SplashViewReactor) {
        showHomeSubjet
            .map { SplashViewReactor.Action.showHome }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    func bindState(reactor: SplashViewReactor) {
        reactor.state
            .subscribe()
            .disposed(by: disposeBag)
    }
}
