//
//  KeywordSelectCell.swift
//  KIDA
//
//  Created by choidam on 2022/01/24.
//
import UIKit

class KeywordSelectCell: BaseCollectionViewCell<KeywordSelectCellReactor> {
    
    // MARK: UI
    
    private weak var cardImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func bind(reactor: KeywordSelectCellReactor) {
        
    }
    
}

extension KeywordSelectCell {
    private func setupViews(){
        cardImage = UIImageView().then {
            $0.image = UIImage(named: "card_01")
            $0.contentMode = .scaleToFill
            addSubview($0)
        }
    }
    
    private func setupLayoutConstraints(){
        cardImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
