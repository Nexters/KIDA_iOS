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

    // MARK: - Properties
    var disposeBag = DisposeBag()
    private var popupCoordinator: PopupCoordinator?
    private var keywordSelectCoordinator: KeywordSelectCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .KIDA_background()

        setDefaultNavigation()
        setupNavigationBar()
        setupViews()
        setupLayoutConstraints()
    }

    // MARK: - Methods for override.
    /// 기본 네비게이션바 설정 내용입니다.
    func setDefaultNavigation(){
        let leftButton = UIButton().then {
            $0.setImage(UIImage(named: "ic_logo"), for: .normal)
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)

        leftButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self,
                      let navigationController = self.navigationController else {
                          return
                      }
                self.startKeywordSelect(presenter: navigationController)
            })
            .disposed(by: disposeBag)
    }
    
    /// 네비게이션바를 정의합니다.
    func setupNavigationBar(){
    }
    
    /// 네비게이션바 오른쪽 버튼을 정의합니다.
    func setupNavigationRightButton(buttonType: RightButtonType?){
        let rightButon = UIButton().then {
            $0.setImage(buttonType!.image, for: .normal)
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButon)

        rightButon.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self,
                      let navigationController = self.navigationController,
                      let buttonType = buttonType else {
                          return
                      }

                switch buttonType {
                case .close:
                    self.dismiss(animated: true, completion: nil)
                case .info:
                    self.startPopup(presenter: navigationController,
                                    popupType: .info)
                }
            })
            .disposed(by: disposeBag)
    }
    
    /// 네비게이션바 타이틀을 정의합니다.
    func setupNavigationBarTitle(title: String) {
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

private extension BaseViewController {
    func startKeywordSelect(presenter: UINavigationController) {
        let keywordSelectCoordinator = KeywordSelectCoordinator(navigationController: presenter)
        self.keywordSelectCoordinator = keywordSelectCoordinator
        self.keywordSelectCoordinator?.start()
    }

    func startPopup(presenter: UINavigationController,
                    popupType: PopupType) {
        let popupCoordinator = PopupCoordinator(navigationController: presenter,
                                                popupType: popupType)
        self.popupCoordinator = popupCoordinator
        self.popupCoordinator?.start()
    }
}
