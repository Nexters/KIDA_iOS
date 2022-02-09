//
//  PopupInfoViewController.swift
//  KIDA
//
//  Created by Ian on 2022/02/09.
//

import UIKit

final class PopupInfoViewController: BaseViewController, ServiceDependency {

    // MARK: - Properties
    private weak var containerView: UIView!
    private weak var closeButton: UIButton!
    private weak var headerView: PopupInfoHeaderView!
    private weak var primaryDescription: UILabel!
    private weak var secondaryDescription: UILabel!
    private weak var gotoSelectButton: UIButton!


    private let reactor: PopupInfoReactor

    init(reactor: PopupInfoReactor) {
        self.reactor = reactor

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .KIDA_dimmed()
        bind(reactor: reactor)
    }

    override func setupViews() {
        self.containerView = UIView().then {
            $0.backgroundColor = .KIDA_background2()
            $0.layer.cornerRadius = 10
            view.addSubview($0)
        }

        self.closeButton = UIButton().then {
            $0.setImage(UIImage(named: "ic_close"), for: .normal)
            $0.contentEdgeInsets = .init(top: 0, left: 10, bottom: 10, right: 10)
            containerView.addSubview($0)
        }

        self.headerView = PopupInfoHeaderView().then {
            containerView.addSubview($0)
        }

        self.primaryDescription = UILabel().then {
            let attrString = NSMutableAttributedString(string: KIDA_String.Popup.Info.primaryDescription,
                                                       attributes: [.font: UIFont.systemFont(ofSize: 28, weight: .semibold)])
            $0.attributedText = attrString
            $0.numberOfLines = 2
            $0.textAlignment = .center
            containerView.addSubview($0)
        }

        self.secondaryDescription = UILabel().then {
            let attrString = NSMutableAttributedString(string: KIDA_String.Popup.Info.secondaryDescription,
                                                       attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .regular),
                                                                    .foregroundColor: UIColor.systemGray])
            $0.attributedText = attrString
            $0.textAlignment = . center
            $0.numberOfLines = 3
            containerView.addSubview($0)
        }

        self.gotoSelectButton = UIButton().then {
            $0.setTitle(KIDA_String.Popup.Info.buttonTitle, for: .normal)
            $0.backgroundColor = .KIDA_orange()
            $0.layer.cornerRadius = 8
            containerView.addSubview($0)
        }
    }

    override func setupLayoutConstraints() {

        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(90)
            $0.leading.equalToSuperview().offset(34)
            $0.trailing.equalToSuperview().offset(-34)
            $0.height.equalToSuperview().multipliedBy(0.65)
        }

        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }

        headerView.snp.makeConstraints {
            $0.top.equalTo(closeButton).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(200)
        }

        primaryDescription.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }

        secondaryDescription.snp.makeConstraints { 
            $0.top.equalTo(primaryDescription.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }

        gotoSelectButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-28)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(secondaryDescription)
            $0.height.equalTo(50)
        }
    }

    func bind(reactor: PopupInfoReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
}

private extension PopupInfoViewController {
    func bindAction(_ reactor: PopupInfoReactor) {
        closeButton.rx.tap
            .map { PopupInfoReactor.Action.didTapClose }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        gotoSelectButton.rx.tap
            .map { PopupInfoReactor.Action.didTapGotoSelect }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    func bindState(_ reactor: PopupInfoReactor) {
        reactor.state
            .subscribe()
            .disposed(by: disposeBag)
    }
}
