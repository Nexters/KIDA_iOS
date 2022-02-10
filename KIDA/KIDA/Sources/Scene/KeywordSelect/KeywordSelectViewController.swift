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
    private weak var selectButton: UIButton!
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(reactor: reactor!) // TODO: 추후에 수정
    }
    
    override func setupNavigationBar() {
        setupNavigationBarTitle(title: Date().toStringTypeTwo)
        setupNavigationRightButton(buttonType: .info)
    }
    
    override func setupViews() {
        initCollectionView()
        view.addSubview(collectionView)
        
        titleLabelOne = UILabel().then {
            $0.text = KIDA_String.KeywordSelect.titleOne
            $0.font = .pretendard(.SemiBold, size: 28)
            $0.textColor = .white
            view.addSubview($0)
        }
        
        titleLabelTwo = UILabel().then {
            $0.text = KIDA_String.KeywordSelect.titleTwo
            $0.font = .pretendard(.SemiBold, size: 28)
            $0.textColor = .white
            view.addSubview($0)
        }
        
        selectButton = UIButton().then {
            $0.setImage(UIImage(named: "ic_btn_default"), for: .normal)
            view.addSubview($0)
        }
    }

    override func setupLayoutConstraints() {
        titleLabelOne.snp.makeConstraints {
            $0.top.equalTo(100) // TODO: 추후에 수정
            $0.leading.equalTo(40)
        }
        
        titleLabelTwo.snp.makeConstraints {
            $0.top.equalTo(titleLabelOne.snp.bottom).offset(8)
            $0.leading.equalTo(40)
        }
        
        selectButton.snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.trailing.equalTo(-40)
            $0.top.equalTo(titleLabelTwo.snp.bottom)
        }
        
        // TODO: UI 수정
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(0)
            $0.trailing.equalTo(0)
            $0.height.equalTo(300)
            $0.top.equalTo(titleLabelTwo.snp.bottom).offset(100)
        }
    }
    
    private func initCollectionView(){
        let flowLayout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 0
            $0.minimumInteritemSpacing = 0
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.isPagingEnabled = true
            $0.register(Reuse.keywordCell)
        }
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.delegate = self
    }

    func bind(reactor: KeywordSelectViewReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
}

extension KeywordSelectViewController {
    func bindState(reactor: KeywordSelectViewReactor){
        guard let collectionView = collectionView else {
            return
        }

        reactor.state
            .map { $0.sections }
            .filter { !$0.isEmpty }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

    func bindAction(reactor: KeywordSelectViewReactor){
    }
}

extension KeywordSelectViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 300
        
        return CGSize(width: width, height: height)
    }
}
