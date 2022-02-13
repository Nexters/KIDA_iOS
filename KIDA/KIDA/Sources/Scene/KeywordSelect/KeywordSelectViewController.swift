//
//  KeywordSelectViewController.swift
//  KIDA
//
//  Created by choidam on 2022/01/23.
//

import UIKit
import RxDataSources
import FlexiblePageControl

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
    private weak var pageControl: FlexiblePageControl!
    
    private var collectionView: UICollectionView!
    
    // MARK: Property
    
    private var keywordCount: Int = 6
    
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
            headerView.addSubview($0)
        }
        
        pageControl = FlexiblePageControl().then {
            $0.numberOfPages = self.keywordCount
            $0.pageIndicatorTintColor = .white
            $0.currentPageIndicatorTintColor = .KIDA_orange()
            headerView.addSubview($0)
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
        
        pageControl.snp.makeConstraints {
            $0.leading.equalTo(headerView.snp.leading)
            $0.bottom.equalTo(headerView.snp.bottom)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom).offset(29)
            $0.bottom.equalTo(-23)
        }
    }
    
    private func initCollectionView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 20
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: self.view.frame.width - 80,
                                     height: UIScreen.main.bounds.height - 300)

        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: flowLayout)
        collectionView.register(Reuse.keywordCell)
        collectionView.decelerationRate = .fast
        collectionView.contentInset = .init(top: 0, left: 40, bottom: 0, right: 40)
        collectionView.isPagingEnabled = false
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
    }

    func bind(reactor: KeywordSelectViewReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
}

extension KeywordSelectViewController {
    func bindState(reactor: KeywordSelectViewReactor){
//        guard let collectionView = collectionView else {
//            return
//        }

//        reactor.state
//            .map { $0.sections }
//            .filter { !$0.isEmpty }
//            .bind(to: collectionView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
    }

    func bindAction(reactor: KeywordSelectViewReactor){
    }
}

extension KeywordSelectViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.keywordCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: KeywordSelectCell = collectionView.dequeueReusableCell(withReuseIdentifier: Reuse.keywordCell.identifier,
                                                                               for: indexPath) as? KeywordSelectCell else {
            return UICollectionViewCell()
        }

        cell.configure(indexPath: indexPath)
        return cell
    }
}

extension KeywordSelectViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }

        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing

        let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing

        let index: Int
        if velocity.x > 0 {
            index = Int(ceil(estimatedIndex))
        } else if velocity.x < 0 {
            index = Int(floor(estimatedIndex))
        } else {
            index = Int(round(estimatedIndex))
        }

        var xPoint = CGFloat(index) * cellWidthIncludingSpacing
        xPoint -= 40
        
        targetContentOffset.pointee = CGPoint(x: xPoint,
                                              y: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cells = collectionView.visibleCells

        for cell in cells {
            cell.isSelected = false
        }

        guard let selectCell = collectionView.cellForItem(at: indexPath) as? KeywordSelectCell else {
            fatalError()
        }

        selectCell.isSelected = !selectCell.isSelected
    }
    
}
