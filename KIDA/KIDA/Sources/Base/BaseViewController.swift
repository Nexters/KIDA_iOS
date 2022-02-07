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

        setDefaultNavigation()
        setupNavigationBar()
        setupViews()
        setupLayoutConstraints()
    }
    
    /// 기본 네비게이션바 설정 내용입니다.
    func setDefaultNavigation(){
        self.navigationController?.navigationBar.tintColor = .KIDA_orange()
        
        let logoButton = UIBarButtonItem(image: UIImage(named: "ic_logo"), style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = logoButton
    }
    
    /// 네비게이션바를 정의합니다.
    func setupNavigationBar(){
    }
    
    /// 네비게이션바 오른쪽 버튼을 정의합니다.
    func setupNavigationRightButton(buttonType: RightButtonType?){
        let button = UIBarButtonItem(image: buttonType?.image, style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = button
    }
    
    /// 네비게이션바 타이틀을 정의합니다.
    func setupNavigationBarTitle(title: String){
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = title
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
