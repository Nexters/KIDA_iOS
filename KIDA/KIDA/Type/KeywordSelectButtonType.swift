//
//  KeywordSelectButtonType.swift
//  KIDA
//
//  Created by choidam on 2022/02/10.
//

import UIKit

enum KeywordSelectButtonType {
    case defaultButton
    case hoverButton
}

extension KeywordSelectButtonType {
    var buttonImage: UIImage? {
        switch self {
        case .defaultButton:
            return UIImage(named: "ic_btn_default")
        case .hoverButton:
            return UIImage(named: "ic_btn_hover")
        }
    }
}
