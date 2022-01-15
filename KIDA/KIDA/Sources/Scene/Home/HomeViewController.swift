//
//  HomeViewController.swift
//  KIDA
//
//  Created by Ian on 2022/01/15.
//

import UIKit

final class HomeViewController: BaseViewController, ServiceDependency {

    // MARK: UI
    
    private let testButton = UIButton()
    
    
    // MARK: Property
    
    var reactor: HomeViewReactor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupViews() {
        testButton.setTitle("testButton", for: .normal)
        testButton.setTitleColor(.black, for: .normal)
        view.addSubview(testButton)
    }

    override func setupLayoutConstraints() {
        testButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    func bind(reactor: HomeViewReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
}

extension HomeViewController {
    
    func bindState(reactor: HomeViewReactor){
        
        testButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.view.backgroundColor = .yellow
            })
            .disposed(by: disposeBag)
        
    }
    
    func bindAction(reactor: HomeViewReactor){
    }
}
