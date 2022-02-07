//
//  RightButtonType.swift
//  KIDA
//
//  Created by choidam on 2022/02/07.
//

import UIKit

enum RightButtonType {
    case close
    case info
}

extension RightButtonType {
    var image: UIImage? {
        switch self {
        case .close:
            return UIImage(named: "ic_close")
        case .info:
            return UIImage(named: "ic_info")
        }
    }
}
