//
//  SelectedKeywordViewController.swift
//  KIDA
//
//  Created by Ian on 2022/01/15.
//

import UIKit

final class SelectedKeywordViewController: BaseViewController, ServiceDependency {

    // MARK: - UI
//    private weak var todayKeywordLabel: UILabel!
//    private weak var selectedKeywordLabel: UILabel!
//    private weak var characterImageView: UIImageView!
//    private weak var confirmButton: UIButton!
//    private weak var rePickButton: UIButton!

    private weak var bottomPopupView: UIView!
    private weak var selectedKeywordGuideLabel: UILabel!
    private weak var selectedkeywordLabelButton: UIButton!
    private weak var gotoWriteDiaryButton: UIButton!
    private weak var rePickButton: UIButton!

    private weak var cardImageView: UIImageView!
    private weak var leftParticleView: UIImageView!
    private weak var rightParticleView: UIImageView!

    // MARK: - Property
    private var reactor: SelectedKeywordReactor
    private let selectedCardIndex: Int

    init(reactor: SelectedKeywordReactor, selectedCardIndex: Int) {
        self.reactor = reactor
        self.selectedCardIndex = selectedCardIndex

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
        self.bottomPopupView = UIView().then {
            $0.backgroundColor = .KIDA_background2()
            $0.cornerRadius([.topLeft, .topRight], radius: 20)
            view.addSubview($0)
        }

        self.selectedKeywordGuideLabel = UILabel().then {
            $0.textColor = .KIDA_orange()
            $0.font = .pretendard(size: 14)
            $0.text = KIDA_String.SelectedKeyword.selectedKeywordGuide
            bottomPopupView.addSubview($0)
        }

        self.selectedkeywordLabelButton = UIButton().then {
            $0.titleLabel?.font = .pretendard(.SemiBold, size: 24)
            $0.setTitle(PersistentStorage.shared.todayKeyword, for: .normal)
            $0.contentEdgeInsets = .init(top: 13, left: 20, bottom: 15, right: 20)
            $0.backgroundColor = .KIDA_background3()
            $0.layer.cornerRadius = 20
            $0.isUserInteractionEnabled = false
            bottomPopupView.addSubview($0)
        }

        self.gotoWriteDiaryButton = UIButton().then {
            $0.setTitle(KIDA_String.SelectedKeyword.goToWriteDiaryTitle, for: .normal)
            $0.backgroundColor = .KIDA_orange()
            $0.cornerRadius(radius: 8)
            bottomPopupView.addSubview($0)
        }

        self.rePickButton = UIButton().then {
            let attrString = NSMutableAttributedString(string: KIDA_String.SelectedKeyword.rePickTitle,
                                                       attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                                    .foregroundColor: UIColor.systemGray,
                                                                    .font: UIFont.pretendard(size: 14)])
            $0.setAttributedTitle(attrString, for: .normal)
            $0.backgroundColor = .clear
            bottomPopupView.addSubview($0)
        }

        self.cardImageView = UIImageView().then {
            // TODO: 추후 Image Asset명 넣어주기
//            $0.image = UIImage(named: "splash")
            $0.image = UIImage(named: "card_0\(selectedCardIndex + 1)")
            $0.contentMode = .scaleAspectFit
            view.addSubview($0)
        }

        self.leftParticleView = UIImageView().then {
            $0.image = UIImage(named: "img_left_particle")
            $0.contentMode = .scaleAspectFit
            view.addSubview($0)
        }

        self.rightParticleView = UIImageView().then {
            $0.image = UIImage(named: "img_right_particle")
            $0.contentMode = .scaleAspectFit
            view.addSubview($0)
        }
    }

    override func setupLayoutConstraints() {

        cardImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            $0.height.equalTo(340)
            $0.centerX.equalToSuperview()
        }

        leftParticleView.snp.makeConstraints {
            $0.trailing.equalTo(cardImageView.snp.leading)
            $0.bottom.equalTo(cardImageView).offset(-17)
        }

        rightParticleView.snp.makeConstraints {
            $0.leading.equalTo(cardImageView.snp.trailing)
            $0.bottom.equalTo(leftParticleView)
        }

        bottomPopupView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(cardImageView.snp.bottom).offset(-80)
        }

        selectedKeywordGuideLabel.snp.makeConstraints {
            $0.top.equalTo(cardImageView.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }

        selectedkeywordLabelButton.snp.makeConstraints {
            $0.top.equalTo(selectedKeywordGuideLabel.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }

        rePickButton.snp.makeConstraints {
            $0.width.equalTo(75)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }

        gotoWriteDiaryButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(rePickButton.snp.top).offset(-15)
            $0.height.equalTo(50)
        }
    }

    override func setupNavigationBar() {
        setupNavigationBarTitle(title: Date().toStringTypeTwo)
        setupNavigationRightButton(buttonType: .info)
    }

    func bind(reactor: SelectedKeywordReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
}

private extension SelectedKeywordViewController {
    func bindAction(reactor: SelectedKeywordReactor) {
        gotoWriteDiaryButton.rx.tap
            .map { SelectedKeywordReactor.Action.didTapGotoWriteButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        rePickButton.rx.tap
            .map { SelectedKeywordReactor.Action.didTapRePickButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    func bindState(reactor: SelectedKeywordReactor) {
        reactor.state
            .subscribe()
            .disposed(by: disposeBag)
    }

}
