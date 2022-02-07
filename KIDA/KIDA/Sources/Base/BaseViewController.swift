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

class BaseViewController: UIViewController {
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        setupNavigationBar()
        setupViews()
        setupLayoutConstraints()
    }
    
    /// 네비게이션바를 정의합니다.
    func setupNavigationBar(){
        
    }

    /// UI를 정의합니다.
    func setupViews() {
        // Override Layout.
    }

    /// UI 제약사항을 정의합니다.
    func setupLayoutConstraints() {
        // Override Constraints.
    }
    
    deinit {
        print("deinit : \(self)")
    }

}
