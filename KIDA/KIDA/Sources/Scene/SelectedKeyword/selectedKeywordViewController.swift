//
//  SelectedKeywordViewController.swift
//  KIDA
//
//  Created by Ian on 2022/01/15.
//

import UIKit

final class SelectedKeywordViewController: BaseViewController, ServiceDependency {

    // MARK: - UI
    private weak var todayKeywordLabel: UILabel!
    private weak var selectedKeywordLabel: UILabel!
    private weak var characterImageView: UIImageView!
    private weak var confirmButton: UIButton!
    private weak var rePickButton: UIButton!

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

        bind(reactor: reactor)
    }

    override func setupViews() {
        self.todayKeywordLabel = UILabel().then {
            $0.text = "오늘의 키워드"
            $0.font = .systemFont(ofSize: 20)
            view.addSubview($0)
        }

        self.selectedKeywordLabel = UILabel().then {
            $0.font = .systemFont(ofSize: 30, weight: .bold)
            $0.text = "여행"
            view.addSubview($0)
        }

        self.characterImageView = UIImageView().then {
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .white
            view.addSubview($0)
        }

        self.confirmButton = UIButton().then {
            $0.backgroundColor = .black
            $0.setTitle("확인", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
            $0.layer.cornerRadius = 12
            view.addSubview($0)
        }

        self.rePickButton = UIButton().then {
            // TODO: 추후 KIDA_String 으로 관리
            let attributedString = NSMutableAttributedString(string: "다시 뽑을래",
                                                             attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                                          .font: UIFont.systemFont(ofSize: 15),
                                                                          .foregroundColor: UIColor.systemGray])
            $0.backgroundColor = .clear
            $0.setAttributedTitle(attributedString, for: .normal)
            view.addSubview($0)
        }
    }

    override func setupLayoutConstraints() {
        let sideMargin: CGFloat = 55

        todayKeywordLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
        }

        selectedKeywordLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(todayKeywordLabel.snp.bottom).offset(12)
        }

        characterImageView.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
            // TODO: 임시로 height 지정, 에셋 받은 이후 변경 예정
            $0.top.equalTo(selectedKeywordLabel.snp.bottom).offset(35)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(280)
        }

        confirmButton.snp.makeConstraints {
            $0.top.equalTo(characterImageView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(sideMargin)
            $0.trailing.equalToSuperview().offset(-sideMargin)
            $0.height.equalTo(56)
        }

        rePickButton.snp.makeConstraints {
            $0.top.equalTo(confirmButton.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(confirmButton)
            $0.height.equalTo(56)
        }
    }

    func bind(reactor: SelectedKeywordReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
}

private extension SelectedKeywordViewController {
    func bindAction(reactor: SelectedKeywordReactor) {
        confirmButton.rx.tap
            .map { SelectedKeywordReactor.Action.didTapConfirmButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        rePickButton.rx.tap
            .map { SelectedKeywordReactor.Action.didTapRePickButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    func bindState(reactor: SelectedKeywordReactor) {
        reactor.state
            .asDriverSkipError()
            .drive()
            .disposed(by: disposeBag)
    }

}
