//
//  KeywordSelectViewController.swift
//  KIDA
//
//  Created by choidam on 2022/01/23.
//

import UIKit
import RxDataSources
import RxSwift

final class KeywordSelectViewController: BaseViewController, ServiceDependency {
    
    fileprivate struct Reuse {
        static let keywordCell = ReuseCell<KeywordSelectCell>()
    }
    
    // MARK: UI
    
    // TODO: '느낌충만하게' 키워드에 하이라이트를 어떻게 해야할지 고민중,,
    private var titleLabel: UILabel!
    
    private var collectionView: UICollectionView!
    
    private lazy var dataSource = KeywordSelectViewController.dataSourceFactory()
    
    private static func dataSourceFactory() -> RxCollectionViewSectionedReloadDataSource<KeywordSelectSection> {
        return .init(
            configureCell: { dataSource, collectionView, indexPath, sectionItem in
                let cell = collectionView.dequeue(Reuse.keywordCell, for: indexPath)
                
                switch sectionItem {
                case .item(let reactor):
                    cell.reactor = reactor
                }
                
                return cell
        })
    }
    
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
        initCollectionView()
        
        view.addSubview(collectionView)
        
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
        
        collectionView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(300)
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.delegate = self
    }
    
    private func initCollectionView(){
        let flowLayout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 0
            $0.minimumInteritemSpacing = 0
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
            $0.backgroundColor = .blue // test
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.isPagingEnabled = true
            $0.register(Reuse.keywordCell)
        }
    }
    
}

extension KeywordSelectViewController {
    private func bindState(reactor: KeywordSelectViewReactor){
        
        // 오류 ,, 왜죠
//        reactor.state
//            .compactMap { $0.sections }
//            .filter { !$0.isEmpty }
//            .bind(to: collectionView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
        
    }
    
    private func bindAction(reactor: KeywordSelectViewReactor){
        
    }
}

extension KeywordSelectViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 300
        
        return CGSize(width: width, height: height)
    }
}
