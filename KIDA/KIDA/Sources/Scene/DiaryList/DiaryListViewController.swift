//
//  DiaryListViewController.swift
//  KIDA
//
//  Created by choidam on 2022/01/17.
//

import UIKit
import RxDataSources

final class DiaryListViewController: BaseViewController, ServiceDependency {

    // MARK: UI
    
    fileprivate struct Reuse {
        static let diaryListCell = ReuseCell<DiaryListCell>()
    }
    
    private lazy var tableView = UITableView()
    
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
        tableView.register(Reuse.diaryListCell)
        view.addSubview(tableView)
        
    }

    override func setupLayoutConstraints() {
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(0)
        }
    }

    func bind(reactor: DiaryListViewReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
}

extension DiaryListViewController {

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
