//
//  KeywordToolTipViews.swift
//  KIDA
//
//  Created by choidam on 2022/02/10.
//

import Foundation
import UIKit

final class KeywordToolTipView: UIView {
    
    // MARK: UI
    private weak var tooltipImageView: UIImageView!
    private weak var tooltipLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        tooltipImageView = UIImageView().then {
            $0.image = UIImage(named: "ic_tooltip")
            addSubview($0)
        }
        
        tooltipLabel = UILabel().then {
            $0.text = KIDA_String.KeywordSelect.tooltipTitle
            $0.font = .pretendard(size: 12)
            $0.textColor = .white
            addSubview($0)
        }
    }
    
    private func setupLayoutConstraints(){
        tooltipImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tooltipLabel.snp.makeConstraints {
            $0.top.equalTo(tooltipImageView.snp.top).offset(8)
            $0.centerX.equalTo(tooltipImageView.snp.centerX)
        }
    }
    
}
