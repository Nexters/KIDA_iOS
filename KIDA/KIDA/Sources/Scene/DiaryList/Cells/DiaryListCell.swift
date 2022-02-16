//
//  DiaryListCell.swift
//  KIDA
//
//  Created by choidam on 2022/01/17.
//

import UIKit

final class DiaryListCell: BaseTableViewCell<DiaryListCellReactor> {
    
    // MARK: UI
    
    private weak var topView: DiaryListTopView!
    private weak var bottomView: DiaryListBottomView!
    private weak var rightPolygonImageView: UIImageView!
    
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
            .map { $0.diary }
            .subscribe(onNext: { [weak self] diary in
                guard let self = self else {
                    return
                }
                
                self.topView.keyword = diary.keyword
                self.topView.date = diary.createdAt.toStringTypeOne
                self.topView.title = diary.title
                
                self.bottomView.content = diary.content
            })
            .disposed(by: disposeBag)
    }
}

extension DiaryListCell {
    private func setupViews() {
        backgroundColor = .KIDA_background()
        
        topView = DiaryListTopView().then {
            addSubview($0)
        }
        
        rightPolygonImageView = UIImageView().then {
            $0.image = UIImage(named: "ic_right_arrow")
            addSubview($0)
        }
        
        bottomView = DiaryListBottomView().then {
            addSubview($0)
        }
    }

    private func setupLayoutConstraints() {
        
        topView.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.top.equalTo(12)
        }
        
        rightPolygonImageView.snp.makeConstraints {
            $0.centerY.equalTo(topView.snp.centerY)
            $0.width.height.equalTo(22)
            $0.trailing.equalTo(-8)
        }
        
        bottomView.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.top.equalTo(topView.snp.bottom)
            $0.bottom.equalTo(-12)
        }
        
    }
}
