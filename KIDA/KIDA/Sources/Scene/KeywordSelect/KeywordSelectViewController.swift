//
//  KeywordSelectViewController.swift
//  KIDA
//
//  Created by choidam on 2022/01/23.
//

import UIKit
import RxDataSources
import RxCocoa
import AdvancedPageControl

final class KeywordSelectViewController: BaseViewController, ServiceDependency {

    fileprivate struct Reuse {
        static let keywordCell = ReuseCell<KeywordSelectCell>()
    }
    
    // MARK: UI
    
    private let headerView = UIView()
    
    private let titleLabelOne = UILabel().then {
        $0.text = KIDA_String.KeywordSelect.titleOne
        $0.font = .pretendard(.SemiBold, size: 28)
        $0.textColor = .white
    }
    
    private let titleLabelTwo = UILabel().then {
        $0.text = KIDA_String.KeywordSelect.titleTwo
        $0.font = .pretendard(.SemiBold, size: 28)
        $0.textColor = .white
    }
    
    private let selectButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_btn_default"), for: .normal)
    }
    
    private let keywordTooltip = KeywordToolTipView().then {
        $0.alpha = 0
    }
    
    private lazy var pageControl = AdvancedPageControlView().then {
        $0.drawer = ExtendedDotDrawer(numberOfPages: keywordCount,
                                      height: 6,
                                      width: 6,
                                      space: 6,
                                      indicatorColor: .KIDA_orange(),
                                      dotsColor: .gray,
                                      isBordered: false,
                                      borderColor: .white,
                                      borderWidth: 0,
                                      indicatorBorderColor: .KIDA_orange(),
                                      indicatorBorderWidth: 6)
    }
    
    private var collectionView: UICollectionView!
    
    // MARK: Property
    
    private let selectedCardIndexRelay = BehaviorRelay<Int>(value: 0)
    
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
    }
    
    override func setupNavigationBar() {
        setupNavigationBarTitle(title: Date().toStringTypeTwo)
        setupNavigationRightButton(buttonType: .info)
    }
    
    override func setupViews() {
        initCollectionView()
        
        view.addSubview(headerView)
        view.addSubview(collectionView)
        
        headerView.addSubview(titleLabelOne)
        headerView.addSubview(titleLabelTwo)
        headerView.addSubview(selectButton)
        headerView.addSubview(pageControl)
        headerView.addSubview(keywordTooltip)
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
            $0.width.equalTo(78) // TODO: 고치기 
            $0.height.equalTo(6)
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
                                          collectionViewLayout: flowLayout).then {
            $0.register(Reuse.keywordCell)
            $0.decelerationRate = .fast
            $0.contentInset = .init(top: 0, left: 40, bottom: 0, right: 40)
            $0.isPagingEnabled = false
            $0.dataSource = self
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .clear
            $0.delegate = self
        }
        
    }

    func bind(reactor: KeywordSelectViewReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
}

extension KeywordSelectViewController {
    func bindState(reactor: KeywordSelectViewReactor){
        
    }

    func bindAction(reactor: KeywordSelectViewReactor){
        selectButton.rx.tap
            .map { [weak self] _ in self?.selectedCardIndexRelay.value ?? 0 }
            .map { Reactor.Action.didSelectCard(cardIndex: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
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

        didTouchCard(false)
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing

        let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing

        let index: Int
        if velocity.x > 0 {
            index = min(Int(ceil(estimatedIndex)), keywordCount-1)
        } else if velocity.x < 0 {
            index = max(Int(floor(estimatedIndex)), 0)
        } else {
            index = Int(round(estimatedIndex))
        }

        // MARK: page control event
        
        self.pageControl.setPage(index)
        
        // MARK: cell drag event
        
        let indexPath: IndexPath = IndexPath(item: index, section: 0)
        let cells = collectionView.visibleCells
        for cell in cells {
            cell.isSelected = false
        }
        
        guard let selectCell = collectionView.cellForItem(at: indexPath) as? KeywordSelectCell else { return }
        
        selectedCardIndexRelay.accept(indexPath.item)
        selectCell.isSelected = !selectCell.isSelected
        didTouchCard(true)
        
        // MARK: 셀 위치 조정

        var xPoint = CGFloat(index) * cellWidthIncludingSpacing
        xPoint -= 40
        
        targetContentOffset.pointee = CGPoint(x: xPoint,
                                              y: 0)
    }
}

private extension KeywordSelectViewController {
    func didTouchCard(_ did: Bool) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                guard let self = self else { return }
                self.keywordTooltip.alpha = did ? 1 : 0
            })
            let image = UIImage(named: did ? "ic_btn_hover" : "ic_btn_default")
            self?.selectButton.setImage(image, for: .normal)
        }
    }
}
