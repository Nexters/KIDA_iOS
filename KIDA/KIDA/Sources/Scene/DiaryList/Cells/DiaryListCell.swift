//
//  DiaryListCell.swift
//  KIDA
//
//  Created by choidam on 2022/01/17.
//

import UIKit

final class DiaryListCell: BaseTableViewCell<DiaryListCellReactor> {
    
    // MARK: UI
    
    private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    }
    
}

extension DiaryListCell {
    private func setupViews() {
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        addSubview(titleLabel)
    }

    private func setupLayoutConstraints() {
        setupViews()
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(10)
            $0.centerY.equalToSuperview()
        }
    }
}
