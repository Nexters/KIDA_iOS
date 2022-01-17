//
//  WriteDiaryViewController.swift
//  KIDA
//
//  Created by Ian on 2022/01/17.
//

import Foundation
import UIKit

final class WriteDiaryViewController: BaseViewController, ServiceDependency {

    // MARK: - Properties

    private weak var headerView: UIView!
    private weak var optionButton: UIButton!
    private weak var primaryLabel: UILabel!
    private weak var secondaryLabel: UILabel!
    private weak var changeKeywordButton: UIButton!
    private weak var textView: UITextView!
    private weak var writeButton: UIButton!

    private var reactor: WriteDiaryReactor

    // MARK: - Initializer
    init(reactor: WriteDiaryReactor) {
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
        self.headerView = UIView().then {
            $0.backgroundColor = .white
            view.addSubview($0)
        }

        self.optionButton = UIButton().then {
            $0.setTitle("'''", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            headerView.addSubview($0)
        }

        self.primaryLabel = UILabel().then {
            $0.text = "키워드"
            $0.font = .systemFont(ofSize: 30, weight: .medium)
            headerView.addSubview($0)
        }

        self.secondaryLabel = UILabel().then {
            $0.text = "어쩌구 저쩌구"
            $0.font = .systemFont(ofSize: 15, weight: .regular)
            headerView.addSubview($0)
        }

        self.changeKeywordButton = UIButton().then {
            $0.setTitle("키워드 다시뽑기", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 13
            $0.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            headerView.addSubview($0)
        }

        self.textView = UITextView().then {
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 20, weight: .regular)
            $0.backgroundColor = .systemGray5
            view.addSubview($0)
        }

        self.writeButton = UIButton().then {
            $0.setTitle("일기 남기기", for: .normal)
            $0.backgroundColor = .black
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
            view.addSubview($0)
        }
    }

    override func setupLayoutConstraints() {
        let headerSideMargin: CGFloat = 20
        let textViewSideMargin: CGFloat = 27
        let writeButtonHeight: CGFloat = 60

        headerView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(headerSideMargin)
            $0.top.equalToSuperview().offset(80)
            $0.trailing.equalToSuperview().offset(-headerSideMargin)
            $0.height.equalTo(90)
        }

        optionButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
        }

        primaryLabel.snp.makeConstraints {
            // TODO: 키워드가 길어질 경우 어떻게 할 지 의논 후 제약 변경
            $0.top.equalToSuperview().offset(3)
            $0.leading.equalToSuperview()
        }

        secondaryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(primaryLabel.snp.bottom).offset(15)
        }

        changeKeywordButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(secondaryLabel)
            $0.width.equalTo(115)
        }

        textView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(textViewSideMargin)
            $0.trailing.equalToSuperview().offset(-textViewSideMargin)
            $0.top.equalTo(headerView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().offset(-(writeButtonHeight + 20))
        }

        writeButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(writeButtonHeight)
        }
    }

    func bind(reactor: WriteDiaryReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
}

private extension WriteDiaryViewController {
    func bindAction(reactor: WriteDiaryReactor) {
        optionButton.rx.tap
            .map { WriteDiaryReactor.Action.didTapOptionButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        changeKeywordButton.rx.tap
            .map { WriteDiaryReactor.Action.didTapChangeKeywordButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        writeButton.rx.tap
            .map { WriteDiaryReactor.Action.didTapWriteButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    func bindState(reactor: WriteDiaryReactor) {
        reactor.state
            .subscribe()
            .disposed(by: disposeBag)
    }
}
