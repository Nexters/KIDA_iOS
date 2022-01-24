//
//  KeywordSelectCell.swift
//  KIDA
//
//  Created by choidam on 2022/01/24.
//
import UIKit

class KeywordSelectCell: BaseCollectionViewCell<KeywordSelectCellReactor> {
    
    // MARK: UI
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow // test
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func bind(reactor: KeywordSelectCellReactor) {
        
    }
    
}
