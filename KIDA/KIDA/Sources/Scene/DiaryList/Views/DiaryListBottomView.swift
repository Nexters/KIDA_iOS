//
//  DiaryListBottomView.swift
//  KIDA
//
//  Created by choidam on 2022/02/08.
//

import Foundation
import UIKit

final class DiaryListBottomView: UIView {
    
    // MARK: UI
    
    private weak var wholeView: UIView!
    private weak var contentLabel: UILabel!
    
    // MARK: Property
    
    var content: String = "" {
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

extension DiaryListBottomView {
    private func setupViews(){
        wholeView = UIView().then {
            $0.backgroundColor = UIColor.init(red: 0.23, green: 0.23, blue: 0.23, alpha: 1)
            $0.layer.cornerRadius = 10
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            addSubview($0)
        }
        
        contentLabel = UILabel().then {
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 14)
            $0.numberOfLines = 0
            addSubview($0)
        }
    }
    
    private func setupLayoutConstraints(){
        wholeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.leading.equalTo(wholeView.snp.leading).offset(20)
            $0.trailing.equalTo(wholeView.snp.trailing).offset(-20)
            $0.top.equalTo(wholeView.snp.top).offset(20)
            $0.bottom.equalTo(wholeView.snp.bottom).offset(-20)
        }
    }
    
    private func setText(){
        contentLabel.text = content
    }
}
