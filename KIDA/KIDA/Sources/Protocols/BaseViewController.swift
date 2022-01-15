//
//  BaseViewController.swift
//  KIDA
//
//  Created by Ian on 2022/01/15.
//

import UIKit

class EmptyReactor: Reactor {
    
    enum Action { }
    
    struct State { }
    
    var initialState = State()
}

protocol ServiceDependency: StoryboardView {
    init(reactor: Reactor?)
    
    func bindReactor(reactor: Reactor?)
}

extension ServiceDependency where Self: UIViewController {
    
    func bindReactor(reactor: Reactor? = nil){
        self.reactor = reactor
    }
    
    init(reactor: Reactor? = nil) {
        self.init()
        self.bindReactor(reactor: reactor)
    }
}

class BaseViewController: UIViewController {
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        setupViews()
        setupLayoutConstraints()
    }

    /// UI를 정의합니다.
    func setupViews() {
        // Override Layout.
    }

    /// UI 제약사항을 정의합니다.
    func setupLayoutConstraints() {
        // Override Constraints.
    }

}
