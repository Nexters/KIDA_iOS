//
//  UIFont+.swift
//  KIDA
//
//  Created by Ian on 2022/02/09.
//

import Foundation
import UIKit

extension UIFont {

    enum FontFamily: String {
        case Bold
        case SemiBold
        case Regular
        case Light
        case ExtraLight
    }

    /// Prertendard 폰트로 Regular를 기본값으로 갖습니다.
    static func pretendard(_ family: FontFamily = .Regular, size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-\(family.rawValue)", size: size)!
    }
}
