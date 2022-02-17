//
//  DiaryListHeaderView.swift
//  KIDA
//
//  Created by choidam on 2022/02/05.
//

import UIKit

final class DiaryListHeaderView: UIView {
    
    // MARK: UI
    
    private weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        self.titleLabel = UILabel().then {
            $0.text = KIDA_String.DiaryList.headerTitle
            $0.font = .pretendard(size: 20)
            $0.textColor = .black
            addSubview($0)
        }
    }
    
    private func setupLayoutConstraints(){
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.top.equalTo(30)
            $0.bottom.equalTo(-12)
            $0.height.equalTo(20)
        }
    }
}
