//
//  WriteDiaryViewController.swift
//  KIDA
//
//  Created by Ian on 2022/01/17.
//

import UIKit

enum TextViewEditingStatus {
    case didBegin
    case didEnd
}

final class WriteDiaryViewController: BaseViewController, ServiceDependency {

    // MARK: - Properties
    private weak var containerView: UIView!
    private weak var pickedKeywordGuideLabel: UILabel!
    private weak var pickedKeywordLabel: UILabel!
    private weak var leftImageView: UIImageView!
    private weak var rightImageView: UIImageView!
    private weak var titleView: UIView!
    private weak var titleLabel: UILabel!
    private weak var titleTextField: UITextField!
    private weak var contentView: UIView!
    private weak var contentLabel: UILabel!
    private weak var contentTextView: UITextView!
    private weak var writeButton: UIButton!
    private var tapGestureRecognizer: UITapGestureRecognizer!

    private var reactor: WriteDiaryReactor
    private let diaryKeyword: String

    private let subViewTitleColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)

    // MARK: - Initializer
    init(reactor: WriteDiaryReactor) {
        self.reactor = reactor
        self.diaryKeyword = PersistentStorage.shared.todayKeyword

        super.init(nibName: nil, bundle: nil)
    
        self.navigationController?.navigationItem.leftBarButtonItem?.isEnabled = false
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bind(reactor: reactor) // TODO: 추후에 수정
    }

    override func setupViews() {
        self.containerView = UIView().then {
            $0.backgroundColor = UIColor.init(red: 0.23, green: 0.23, blue: 0.23, alpha: 1)
            $0.layer.cornerRadius = 10
            view.addSubview($0)
        }

        self.tapGestureRecognizer = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGestureRecognizer)

        self.pickedKeywordGuideLabel = UILabel().then {
            $0.text = KIDA_String.WriteDiary.pickedKeyword
            $0.font = .pretendard(size: 15)
            $0.textColor = .KIDA_orange()
            containerView.addSubview($0)
        }

        self.pickedKeywordLabel = UILabel().then {
            $0.text = diaryKeyword
            $0.textColor = .white
            $0.font = .pretendard(.Bold, size: 24)
            containerView.addSubview($0)
        }

        self.leftImageView = UIImageView().then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "img_left_particle")
            containerView.addSubview($0)
        }

        self.rightImageView = UIImageView().then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "img_right_particle")
            containerView.addSubview($0)
        }

        self.titleView = UIView().then {
            $0.backgroundColor = .KIDA_background3()
            $0.layer.cornerRadius = 10
            containerView.addSubview($0)
        }

        self.titleLabel = UILabel().then {
            $0.text = KIDA_String.WriteDiary.titleLabel
            $0.textColor = subViewTitleColor
            $0.font = .pretendard(size: 15)
            titleView.addSubview($0)
        }

        self.titleTextField = UITextField().then {
            $0.attributedPlaceholder = NSAttributedString(string: KIDA_String.WriteDiary.titlePlaceholder,
                                                          attributes: [.foregroundColor: UIColor.lightGray])
            $0.font = .pretendard(size: 15)
            $0.textColor = .white
            titleView.addSubview($0)
        }

        self.contentView = UIView().then {
            $0.backgroundColor = .KIDA_background3()
            $0.layer.cornerRadius = 10
            containerView.addSubview($0)
        }

        self.contentLabel = UILabel().then {
            $0.text = KIDA_String.WriteDiary.contentLabel
            $0.textColor = subViewTitleColor
            $0.font = .pretendard(size: 15)
            contentView.addSubview($0)
        }

        self.contentTextView = UITextView().then {
            $0.textAlignment = .left
            $0.font = .pretendard(size: 15)
            $0.backgroundColor = .clear
            contentView.addSubview($0)
        }

        self.writeButton = UIButton().then {
            $0.backgroundColor = .init(red: 0.43, green: 0.43, blue: 0.43, alpha: 1)
            $0.setTitleColor(subViewTitleColor, for: .normal)
            $0.titleLabel?.font = .pretendard(size: 18)
            $0.layer.cornerRadius = 10
            view.addSubview($0)
        }
    }

    override func setupLayoutConstraints() {
        let containerViewSideMargin: CGFloat = 20
        let subViewSideMargin: CGFloat = 14
        let writeButtonHeight: CGFloat = 50

        writeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
            $0.height.equalTo(writeButtonHeight)
        }

        containerView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(containerViewSideMargin)
            $0.trailing.equalToSuperview().offset(-containerViewSideMargin)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.bottom.equalTo(writeButton.snp.top).offset(-24)
        }

        pickedKeywordGuideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.centerX.equalToSuperview()
        }

        pickedKeywordLabel.snp.makeConstraints {
            $0.top.equalTo(pickedKeywordGuideLabel).offset(20)
            $0.centerX.equalToSuperview()
        }

        leftImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(13)
            $0.top.equalToSuperview().offset(31)
        }

        rightImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-13)
            $0.top.equalToSuperview().offset(31)
        }

        titleView.snp.makeConstraints {
            $0.top.equalTo(pickedKeywordLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-14)
            $0.height.equalTo(80)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }

        titleTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel).offset(20)
            $0.leading.equalTo(titleLabel)
        }

        contentView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(subViewSideMargin)
            $0.trailing.equalToSuperview().offset(-subViewSideMargin)
            $0.bottom.equalToSuperview().offset(-subViewSideMargin)
        }

        contentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }

        contentTextView.snp.makeConstraints {
            $0.top.equalTo(contentLabel).offset(18)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
        }
    }

    override func setupNavigationBar() {
        setupNavigationBarTitle(title: Date().toStringTypeTwo)
        setupNavigationRightButton(buttonType: .close)
    }

    func bind(reactor: WriteDiaryReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
}

private extension WriteDiaryViewController {
    func bindAction(reactor: WriteDiaryReactor) {
        contentTextView.rx.didBeginEditing
            .asDriver()
            .do(onNext: { [weak self] _ in
                self?.textVieweditingAnimation(.didBegin)
            })
            .compactMap { [weak self] _ in self?.contentTextView.text }
            .filter { [weak self] text in
                self?.isPlaceHolderString(text) == true
            }
            .drive(onNext: { [weak self] _ in
                self?.contentTextView.text = nil
                self?.contentTextView.textColor = .white
            })
            .disposed(by: disposeBag)
            
        contentTextView.rx.didEndEditing
            .asDriver()
            .do(onNext: { [weak self] _ in
                self?.textVieweditingAnimation(.didEnd)
            })
            .compactMap { [weak self] _ in self?.contentTextView.text }
            .filter(isEmptyTextView(_:))
            .drive(onNext: { [weak self] _ in
                self?.contentTextView.text = KIDA_String.WriteDiary.contentTextViewPlaceholder
                self?.contentTextView.textColor = .lightGray
            })
            .disposed(by: disposeBag)
        
        writeButton.rx.tap
            .filter { reactor.currentState.isEditing == false }
            .map(makeDiary)
            .map { WriteDiaryReactor.Action.didTapWriteButton($0, didSuccess: false) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        writeButton.rx.tap
            .filter { reactor.currentState.isEditing == true }
            .map { Reactor.Action.updateDiary(title: self.titleTextField.text ?? "", content: self.contentTextView.text ?? "") }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        tapGestureRecognizer.rx.event
            .asDriver()
            .map { $0.state == .recognized }
            .drive(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)

        contentTextView.rx.text
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.checkContentCondition($0)
            })
            .disposed(by: disposeBag)

        titleTextField.rx.text
            .asDriver()
            .drive(onNext: { [weak self] in
                if ($0?.count ?? 0) > 20 {
                    self?.titleTextField.text = String($0?.prefix(20) ?? "")
                }
            })
            .disposed(by: disposeBag)

        Observable.combineLatest(contentTextView.rx.text,
                                 titleTextField.rx.text)
            .asDriverSkipError()
            .map { [weak self] content, title -> Bool in
                guard let self = self else { return false }
                if (content?.isEmpty ?? true || self.isPlaceHolderString(content ?? "")) ||
                    title?.isEmpty ?? true {
                    return false
                } else {
                    return true
                }
            }
            .drive(onNext: { [weak self] writeButtonEnabled in
                guard let self = self else { return }
                self.writeButton.isEnabled = writeButtonEnabled
                self.writeButton.backgroundColor = writeButtonEnabled ? .KIDA_orange() : .KIDA_background2()
                self.writeButton.setTitleColor(writeButtonEnabled ? .white : self.subViewTitleColor,
                                               for: .normal)
            })
            .disposed(by: disposeBag)

    }

    func bindState(reactor: WriteDiaryReactor) {
        reactor.state
            .map { $0.didSuccessCreateDiary }
            .subscribe()
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.keyword }
            .filter { $0 != nil }
            .bind(to: pickedKeywordLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.title }
            .filter { $0 != nil }
            .bind(to: titleTextField.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isEditing }
            .filter { !($0) }
            .map { _ in KIDA_String.WriteDiary.contentTextViewPlaceholder }
            .bind(to: contentTextView.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isEditing }
            .filter { $0 == false }
            .subscribe(onNext: { [weak self] _ in
                self?.contentTextView.text = KIDA_String.WriteDiary.contentTextViewPlaceholder
                self?.contentTextView.textColor = .lightGray // TODO: 추후에 컬러 수정
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { ($0.isEditing, $0.content) }
            .filter { $0.0 == true }
            .subscribe(onNext: { [weak self] (_, content) in
                self?.contentTextView.text = content
                self?.contentTextView.textColor = .white
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isEditing }
            .filter { $0 == true }
            .map { _ in KIDA_String.WriteDiary.writeButtonEditTitle }
            .bind(to: writeButton.rx.title())
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isEditing }
            .filter { $0 == false }
            .map { _ in KIDA_String.WriteDiary.writeButtonCompleteTitle }
            .bind(to: writeButton.rx.title())
            .disposed(by: disposeBag)
    }

    func isPlaceHolderString(_ string: String) -> Bool {
        return string == KIDA_String.WriteDiary.contentTextViewPlaceholder
    }

    func isEmptyTextView(_ string: String) -> Bool {
        return string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func textVieweditingAnimation(_ status: TextViewEditingStatus) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            let yPosition: CGFloat
            switch status {
            case .didBegin:
                yPosition = -50
            case .didEnd:
                yPosition = 0
            }

            self?.view.frame.origin.y = yPosition
        })
    }

    func makeDiary() -> DiaryModel {
        return DiaryModel(content: contentTextView.text,
                          createdAt: Date(),
                          keyword: diaryKeyword,
                          title: titleTextField.text ?? "")
    }

    func checkContentCondition(_ content: String?) {
        guard let content = content else {
            return
        }

        writeButton.backgroundColor = writeButton.isEnabled ? .KIDA_orange() : .KIDA_background2()
        writeButton.setTitleColor(writeButton.isEnabled ? .white : subViewTitleColor, for: .normal)
        if content.count >= 150 {
            contentTextView.text = String(content.prefix(149))
        }
    }
}

