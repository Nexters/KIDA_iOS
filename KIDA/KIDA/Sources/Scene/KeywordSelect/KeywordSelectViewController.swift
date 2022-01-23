//
//  KeywordSelectViewController.swift
//  KIDA
//
//  Created by choidam on 2022/01/23.
//

import UIKit

final class KeywordSelectViewController: BaseViewController, ServiceDependency {
    
    // MARK: UI
    
    // TODO: '느낌충만하게' 키워드에 하이라이트를 어떻게 해야할지 고민중,,
    private weak var titleLabel: UILabel!
    
    var reactor: KeywordSelectViewReactor?
    
    func bind(reactor: KeywordSelectViewReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.title = "title"
    }
    
    override func setupViews() {
        self.titleLabel = UILabel().then {
            $0.text = "오늘의 키워드 어쩌구"
            $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            $0.textColor = .black
            view.addSubview($0)
        }
    }
    
    override func setupLayoutConstraints() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(60)
        }
    }
    
}

extension KeywordSelectViewController {
    private func bindState(reactor: KeywordSelectViewReactor){
        
    }
    
    private func bindAction(reactor: KeywordSelectViewReactor){
        
    }
}
