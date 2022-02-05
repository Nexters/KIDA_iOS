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
    private weak var tagLabel: UILabel!
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
            $0.text = "가을은 내 최애 날씨야~" // test
            $0.font = .systemFont(ofSize: 14, weight: .bold)
            $0.textColor = .black
            wholeView.addSubview($0)
        }
        
        tagLabel = UILabel().then {
            $0.text = "#가을" // test
            $0.font = .systemFont(ofSize: 12)
            $0.textColor = .KIDA_orange()
            wholeView.addSubview($0)
        }
        
        dateLabel = UILabel().then {
            $0.text = "2022.02.04" // test
            $0.font = .systemFont(ofSize: 12)
            $0.textColor = .gray
            wholeView.addSubview($0)
        }
        
        contentLabel = UILabel().then {
            $0.text = """
            가을하면 떠오르는게 뭐냐고 묻는다면 나는 최애 날씨라 하겄어. 왜냐하면 좋기때문이지. 당신들은 그렇지 않아? 나는 가을이 제일 좋아. 왜냐면 옷을 맘대로 입어도 간지가 나잖냐 안그래? 난 그리고 지금 다이어트 중이라 너무 배고파 죽을거같애 어떡하지? 살려줘엉엉엉엉어엉엉
            """ // test
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
        
        tagLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(wholeView.snp.leading).offset(20)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(tagLabel.snp.centerY)
            $0.leading.equalTo(tagLabel.snp.trailing).offset(8)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(22)
            $0.leading.equalTo(wholeView.snp.leading).offset(20)
            $0.trailing.equalTo(wholeView.snp.trailing).offset(-20)
            $0.bottom.equalTo(wholeView.snp.bottom).offset(-20)
        }
    }
}
