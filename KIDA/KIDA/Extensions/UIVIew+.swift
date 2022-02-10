//
//  UIVIew+.swift
//  KIDA
//
//  Created by Ian on 2022/02/10.
//

import UIKit

extension UIView {
    func cornerRadius(_ corners: [UIRectCorner] = [.allCorners], radius: CGFloat) {
            layer.masksToBounds = true
            layer.cornerRadius = radius

            if corners != [.allCorners] {
                var cornerMask = CACornerMask()

                corners.forEach {
                    if $0 == .topLeft {
                        cornerMask.insert(CACornerMask.layerMinXMinYCorner)
                    }
                    if $0 == .topRight {
                        cornerMask.insert(CACornerMask.layerMaxXMinYCorner)
                    }
                    if $0 == .bottomLeft {
                        cornerMask.insert(CACornerMask.layerMinXMaxYCorner)
                    }
                    if $0 == .bottomRight {
                        cornerMask.insert(CACornerMask.layerMaxXMaxYCorner)
                    }
                }

                layer.maskedCorners = cornerMask
            }
        }
}
