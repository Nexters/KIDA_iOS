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
    
    private weak var headerView: UIView!
    private weak var titleLabelOne: UILabel!
    private weak var titleLabelTwo: UILabel!
    private weak var selectButton: UIButton!
    private weak var keywordTooltip: KeywordToolTipView!
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
        
        collectionView.rx.didEndDragging
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                guard let currentIndex = self.collectionView.indexPathsForVisibleItems.first else {
                    return
                }
//                self.collectionView.scrollToItem(at: currentIndex,
//                                                 at: .right,
//                                                 animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    override func setupNavigationBar() {
        setupNavigationBarTitle(title: Date().toStringTypeTwo)
        setupNavigationRightButton(buttonType: .info)
    }
    
    override func setupViews() {
        initCollectionView()
        view.addSubview(collectionView)
        
        headerView = UIView().then {
            view.addSubview($0)
        }
        
        titleLabelOne = UILabel().then {
            $0.text = KIDA_String.KeywordSelect.titleOne
            $0.font = .pretendard(.SemiBold, size: 28)
            $0.textColor = .white
            headerView.addSubview($0)
        }
        
        titleLabelTwo = UILabel().then {
            $0.text = KIDA_String.KeywordSelect.titleTwo
            $0.font = .pretendard(.SemiBold, size: 28)
            $0.textColor = .white
            headerView.addSubview($0)
        }
        
        selectButton = UIButton().then {
            $0.setImage(UIImage(named: "ic_btn_default"), for: .normal)
            headerView.addSubview($0)
        }
        
        keywordTooltip = KeywordToolTipView().then {
            view.addSubview($0)
        }
    }

    override func setupLayoutConstraints() {
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            $0.leading.equalTo(40)
            $0.trailing.equalTo(-40)
            $0.height.equalTo(96)
        }
        
        titleLabelOne.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            $0.leading.equalTo(headerView.snp.leading)
        }
        
        titleLabelTwo.snp.makeConstraints {
            $0.top.equalTo(titleLabelOne.snp.bottom).offset(8)
            $0.leading.equalTo(headerView.snp.leading)
        }
        
        selectButton.snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.trailing.equalTo(headerView.snp.trailing)
            $0.bottom.equalTo(headerView.snp.bottom)
        }
        
        keywordTooltip.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.top).offset(22)
            $0.trailing.equalTo(headerView.snp.trailing)
            $0.width.equalTo(68)
            $0.height.equalTo(32)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(0)
            $0.trailing.equalTo(0)
            $0.top.equalTo(headerView.snp.bottom).offset(29)
            $0.bottom.equalTo(-23)
        }
    }
    
    private func initCollectionView(){
        let flowLayout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 20
            $0.minimumInteritemSpacing = 0
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.isPagingEnabled = true
            $0.register(Reuse.keywordCell)
//            $0.backgroundColor = .KIDA_background()
            $0.backgroundColor = .white
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
        let width: CGFloat = UIScreen.main.bounds.width-80
        let height: CGFloat = UIScreen.main.bounds.height-224 // TODO: 추후에 수정

        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("🌈🌈🌈🌈")
    }
}
