//
//  DiaryListTopView.swift
//  KIDA
//
//  Created by choidam on 2022/02/08.
//

import Foundation
import UIKit

final class DiaryListTopView: UIView {
    
    // MARK: UI
    
    private weak var wholeView: UIView!
    private weak var keywordLabel: UILabel!
    private weak var dateLabel: UILabel!
    private weak var titleLabel: UILabel!
    
    // MARK: Property
    
    var keyword: String = "" {
        didSet {
            setText()
        }
    }
    
    var date: String = "" {
        didSet {
            setText()
        }
    }
    
    var title: String = "" {
        didSet {
            setText()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DiaryListTopView {
    private func setupViews(){
        wholeView = UIView().then {
            $0.backgroundColor = .KIDA_background2()
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            addSubview($0)
        }
        
        keywordLabel = UILabel().then {
            $0.textColor = .KIDA_orange()
            $0.font = .pretendard(size: 12)
            addSubview($0)
        }
        
        dateLabel = UILabel().then {
            $0.textColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
            $0.font = .pretendard(size: 12)
            addSubview($0)
        }
        
        titleLabel = UILabel().then {
            $0.textColor = .white
            $0.font = .pretendard(size: 16)
            addSubview($0)
        }
    }
    
    private func setupLayoutConstraints(){
        wholeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        keywordLabel.snp.makeConstraints {
            $0.top.equalTo(wholeView.snp.top).offset(20)
            $0.leading.equalTo(wholeView.snp.leading).offset(20)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(keywordLabel.snp.centerY)
            $0.leading.equalTo(keywordLabel.snp.trailing).offset(10)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(keywordLabel.snp.bottom).offset(10)
            $0.leading.equalTo(wholeView.snp.leading).offset(20)
            $0.trailing.equalTo(wholeView.snp.trailing).offset(-20)
            $0.bottom.equalTo(wholeView.snp.bottom).offset(-20)
        }
    }
    
    private func setText(){
        self.keywordLabel.text = "#\(keyword)"
        self.dateLabel.text = date
        self.titleLabel.text = title
    }
}
