//
//  SelectedKeywordViewController.swift
//  KIDA
//
//  Created by Ian on 2022/01/15.
//

import UIKit

final class SelectedKeywordViewController: BaseViewController, ServiceDependency {

    // MARK: - UI
    private var containerView: UIView!
    private var closeButton: UIButton!
    private var todayKeywordLabel: UILabel!
    private var selectedKeyword: UILabel!
    private var confirmButton: UIButton!

    // MARK: - Property
    private var reactor: SelectedKeywordReactor

    init(reactor: SelectedKeywordReactor) {
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
        view.backgroundColor = UIColor(white: 1, alpha: 0.4)

        self.containerView = UIView().then {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 17
            view.addSubview($0)
        }

        self.closeButton = UIButton().then {
            $0.setTitle("x", for: .normal)
            $0.setTitleColor(.systemGray, for: .normal)
            containerView.addSubview($0)
        }

        self.todayKeywordLabel = UILabel().then {
            $0.text = KIDA_String.SelectedKeyword.todayKeyword
            $0.font = .systemFont(ofSize: 20)
            containerView.addSubview($0)
        }

        self.selectedKeyword = UILabel().then {
            $0.font = .systemFont(ofSize: 30, weight: .bold)
            $0.text = "여행"
            containerView.addSubview($0)
        }

        self.confirmButton = UIButton().then {
            $0.backgroundColor = .black
            $0.setTitle("확인", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
            $0.layer.cornerRadius = 20
            containerView.addSubview($0)
        }
    }

    override func setupLayoutConstraints() {
        let sideMargine: CGFloat = 20.0

        containerView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(sideMargine)
            $0.trailing.equalToSuperview().offset(-sideMargine)
            $0.height.equalTo(330)
            $0.centerY.equalToSuperview()
        }

        closeButton.snp.makeConstraints {
            $0.top.equalTo(containerView).offset(sideMargine)
            $0.trailing.equalTo(containerView).offset(-sideMargine)
            $0.size.equalTo(CGSize(width: 30, height: 30))
        }

        todayKeywordLabel.snp.makeConstraints {
            $0.centerX.equalTo(containerView)
            $0.top.equalTo(containerView).offset(75)
        }

        selectedKeyword.snp.makeConstraints {
            $0.centerX.equalTo(containerView)
            $0.top.equalTo(todayKeywordLabel.snp.bottom).offset(26)
        }

        confirmButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 183, height: 53))
            $0.centerX.equalTo(containerView)
            $0.bottom.equalTo(containerView).offset(-24)
        }
    }

    func bind(reactor: SelectedKeywordReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
}

private extension SelectedKeywordViewController {
    func bindState(reactor: SelectedKeywordReactor) {

    }

    func bindAction(reactor: SelectedKeywordReactor) {

    }
}
