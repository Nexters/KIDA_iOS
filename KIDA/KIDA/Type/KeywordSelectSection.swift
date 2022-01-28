//
//  KeywordSelect.swift
//  KIDA
//
//  Created by choidam on 2022/01/24.
//

import RxDataSources

enum KeywordSelectSection {
    case section([KeywordSelectSectionItem])
}

extension KeywordSelectSection: SectionModelType {
    var items: [KeywordSelectSectionItem] {
        switch self {
        case .section(let items): return items
        }
    }
    
    init(original: KeywordSelectSection, items: [KeywordSelectSectionItem]) {
        switch original {
        case .section: self = .section(items)
        }
    }
}

enum KeywordSelectSectionItem {
    case item(KeywordSelectCellReactor)
}
