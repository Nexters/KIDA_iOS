//
//  PopupErrorViewController.swift
//  KIDA
//
//  Created by Ian on 2022/02/09.
//

import UIKit

final class PopupErrorViewController: BaseViewController, ServiceDependency {

    // MARK: - Properties
    private weak var containerView: UIView!
    private weak var imageView: UIImageView!
    private weak var closeButton: UIButton!
    private weak var mainLabel: UILabel!
    private weak var primaryDescriptionLabel: UILabel!
    private weak var secondaryDescriptionLabel: UILabel!
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
        view.backgroundColor = .KIDA_dimmed()

        self.containerView = UIView().then {
            $0.backgroundColor = .KIDA_background2()
            $0.layer.cornerRadius = 10
            view.addSubview($0)
        }

        self.imageView = UIImageView().then {
            $0.image = UIImage(named: "img_popup_error")
            $0.contentMode = .scaleAspectFit
            containerView.addSubview($0)
        }

        self.closeButton = UIButton().then {
            $0.setImage(UIImage(named: "ic_close"), for: .normal)
            containerView.addSubview($0)
        }

        self.mainLabel = UILabel().then {
            $0.text = KIDA_String.Popup.Error.mainDescription
            $0.font = .systemFont(ofSize: 15)
            $0.textColor = .KIDA_orange()
            containerView.addSubview($0)
        }

        self.primaryDescriptionLabel = UILabel().then {
            $0.text = KIDA_String.Popup.Error.primaryDescription
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 28, weight: .semibold)
            containerView.addSubview($0)
        }

        self.secondaryDescriptionLabel = UILabel().then {
            $0.text = KIDA_String.Popup.Error.secondaryDescription
            $0.numberOfLines = 3
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .systemGray
            containerView.addSubview($0)
        }

    }

    override func setupLayoutConstraints() {
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(170)
            $0.leading.equalToSuperview().offset(34)
            $0.trailing.equalToSuperview().offset(-34)
            $0.height.equalToSuperview().multipliedBy(0.5)
        }

        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-30)
            $0.centerX.equalToSuperview()
        }

        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }

        mainLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }

        primaryDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }

        secondaryDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(primaryDescriptionLabel.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
        }
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
