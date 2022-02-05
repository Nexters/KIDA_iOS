//
//  DiaryListViewController.swift
//  KIDA
//
//  Created by choidam on 2022/01/17.
//

import UIKit
import RxDataSources

final class DiaryListViewController: BaseViewController, ServiceDependency {

    fileprivate struct Reuse {
        static let diaryListCell = ReuseCell<DiaryListCell>()
    }
    
    // MARK: UI
    
    private lazy var tableView = UITableView()
    
    private var tableHeaderView = DiaryListHeaderView()
    
    // MARK: Property
    
    private static func dataSourceFactory() -> RxTableViewSectionedReloadDataSource<DiaryListSection>{
        return .init(configureCell: { dataSource, tableView, indexPath, sectionItem in
            switch sectionItem {
            case .item(let reactor):
                let cell = tableView.dequeue(Reuse.diaryListCell, for: indexPath)
                cell.reactor = reactor
                return cell
            }
        })
    }
    
    fileprivate var dataSource = DiaryListViewController.dataSourceFactory()
    
    var reactor: DiaryListViewReactor?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupViews() {
        self.navigationItem.title = KIDA_String.DiaryList.navigationTitle
        
        let headerHeight: CGFloat = 62
        
        tableView.register(Reuse.diaryListCell)
        tableView.tableHeaderView = tableHeaderView
        tableView.tableHeaderView?.frame.size = CGSize(width: tableView.frame.width , height: headerHeight)
        
        view.addSubview(tableView)
    }

    override func setupLayoutConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
    }

    func bind(reactor: DiaryListViewReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
}

private extension DiaryListViewController {

    func bindState(reactor: DiaryListViewReactor){
        
        reactor.state
            .map { $0.sections }
            .filter { !$0.isEmpty }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }

    func bindAction(reactor: DiaryListViewReactor){
    }
}
