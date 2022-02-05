//
//  DiaryListCell.swift
//  KIDA
//
//  Created by choidam on 2022/01/17.
//

import UIKit

final class DiaryListCell: BaseTableViewCell<DiaryListCellReactor> {
    
    // MARK: UI
    
    private weak var wholeView: UIView!
    private weak var titleLabel: UILabel!
    private weak var keywordLabel: UILabel!
    private weak var dateLabel: UILabel!
    private weak var contentLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func bind(reactor: DiaryListCellReactor) {
        
        reactor.state
            .map { $0.title }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.keyword }
            .bind(to: keywordLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.createdAt }
            .map { $0.toStringTypeOne }
            .bind(to: dateLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.content }
            .bind(to: contentLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
}

extension DiaryListCell {
    private func setupViews() {
        backgroundColor = .systemGray6
        
        wholeView = UIView().then {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 10
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 0.07
            $0.layer.shadowRadius = 10
            addSubview($0)
        }
        
        titleLabel = UILabel().then {
            $0.font = .systemFont(ofSize: 14, weight: .bold)
            $0.textColor = .black
            wholeView.addSubview($0)
        }
        
        keywordLabel = UILabel().then {
            $0.font = .systemFont(ofSize: 12)
            $0.textColor = .KIDA_orange()
            wholeView.addSubview($0)
        }
        
        dateLabel = UILabel().then {
            $0.font = .systemFont(ofSize: 12)
            $0.textColor = .gray
            wholeView.addSubview($0)
        }
        
        contentLabel = UILabel().then {
            $0.font = .systemFont(ofSize: 12)
            $0.textColor = .black
            $0.numberOfLines = 0
            wholeView.addSubview($0)
        }
    }

    private func setupLayoutConstraints() {
        wholeView.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.top.equalTo(0)
            $0.bottom.equalTo(-12)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(wholeView.snp.top).offset(26)
            $0.leading.equalTo(wholeView.snp.leading).offset(20)
            $0.trailing.equalTo(wholeView.snp.trailing).offset(-20)
        }
        
        keywordLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(wholeView.snp.leading).offset(20)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(keywordLabel.snp.centerY)
            $0.leading.equalTo(keywordLabel.snp.trailing).offset(8)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(22)
            $0.leading.equalTo(wholeView.snp.leading).offset(20)
            $0.trailing.equalTo(wholeView.snp.trailing).offset(-20)
            $0.bottom.equalTo(wholeView.snp.bottom).offset(-20)
        }
    }
}
