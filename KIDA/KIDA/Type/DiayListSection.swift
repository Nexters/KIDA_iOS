//
//  DiayListSection.swift
//  KIDA
//
//  Created by choidam on 2022/01/17.
//

import RxDataSources

enum DiaryListSection {
    case section([DiaryListSectionItem])
}

extension DiaryListSection: SectionModelType {
    var items: [DiaryListSectionItem] {
        switch self {
        case .section(let items): return items
        }
    }
    
    init(original: DiaryListSection, items: [DiaryListSectionItem]) {
        switch original {
        case .section: self = .section(items)
        }
    }
}

enum DiaryListSectionItem {
    case item(DiaryListCellReactor)
}
