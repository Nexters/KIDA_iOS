//
//  KeywordSelectViewController.swift
//  KIDA
//
//  Created by choidam on 2022/01/23.
//

import UIKit
import RxDataSources

final class KeywordSelectViewController: BaseViewController, ServiceDependency {

    fileprivate struct Reuse {
        static let keywordCell = ReuseCell<KeywordSelectCell>()
    }
    
    // MARK: UI
    
    private weak var titleLabelOne: UILabel!
    private weak var titleLabelTwo: UILabel!
    
    var reactor: KeywordSelectViewReactor?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .KIDA_orange()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.navigationItem.title = Date().toStringTypeTwo
        
        let logoButton = UIBarButtonItem(image: UIImage(named: "ic_logo"), style: .plain, target: self, action: nil)
        let infoButton = UIBarButtonItem(image: UIImage(named: "ic_info"), style: .plain, target: self, action: nil)
        
        self.navigationItem.leftBarButtonItem = logoButton
        self.navigationItem.rightBarButtonItem = infoButton
    }
    
    override func setupViews() {
        view.backgroundColor = .KIDA_background()
        
        titleLabelOne = UILabel().then {
            $0.text = KIDA_String.KeywordSelect.titleOne
            $0.font = .systemFont(ofSize: 28, weight: .bold)
            $0.textColor = .white
            view.addSubview($0)
        }
        
        titleLabelTwo = UILabel().then {
            $0.text = KIDA_String.KeywordSelect.titleTwo
            $0.font = .systemFont(ofSize: 28, weight: .bold)
            $0.textColor = .white
            view.addSubview($0)
        }
    }

    override func setupLayoutConstraints() {
        titleLabelOne.snp.makeConstraints {
            $0.top.equalTo(100) // TODO: 수정하기
            $0.leading.equalTo(40)
        }
        
        titleLabelTwo.snp.makeConstraints {
            $0.top.equalTo(titleLabelOne.snp.bottom).offset(8)
            $0.leading.equalTo(40)
        }
    }

    func bind(reactor: KeywordSelectViewReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
}

extension KeywordSelectViewController {

    func bindState(reactor: KeywordSelectViewReactor){
//        reactor.state
//            .map { _ in return "test" }
//            .bind(to: titleLabelOne.rx.text)
//            .disposed(by: disposeBag)
//
        
        
    }

    func bindAction(reactor: KeywordSelectViewReactor){
    }
}
