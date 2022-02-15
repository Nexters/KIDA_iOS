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
    
    // MARK: Property
    
    override var isSelected: Bool {
        willSet {
            if newValue != isSelected { // 값이 변경된 경우에만 호출
                UIView.animate(withDuration: 0.3, animations: { [weak self] in
                    guard let self = self else { return }
                    if self.isSelected {
                        self.frame.origin.y += 15
                    } else {
                        self.frame.origin.y -= 15
                    }
                })
            }
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
    
    override func bind(reactor: KeywordSelectCellReactor) {
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        cardImage.image = nil
    }

    func configure(indexPath: IndexPath) {
        cardImage.image = UIImage(named: "card_0\(indexPath.item + 1)")
    }
}

extension KeywordSelectCell {
    private func setupViews(){
        cardImage = UIImageView().then {
            $0.contentMode = .scaleAspectFit
            contentView.addSubview($0)
        }
    }
    
    private func setupLayoutConstraints(){
        cardImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
